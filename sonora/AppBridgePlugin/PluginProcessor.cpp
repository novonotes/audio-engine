#include "PluginProcessor.h"

#include <AudioEngineCore/Utils/GetProcessId.h>
#include <AudioEngineCore/Utils/LogFile.h>

#include <random>

#include "PluginDevEditor.h"
#include "PluginEditor.h"
#include "Settings/SettingsFile.h"
#include "Utils/JsonUtils.h"
#include "Utils/ProcessLauncher.h"

namespace novonotes
{

static int numInstances = 0;

PluginProcessor::PluginProcessor()
    : AudioProcessor(BusesProperties()
                         .withInput("Input", AudioChannelSet::stereo())
                         .withOutput("Output", AudioChannelSet::stereo()))
    , _settings(Settings::initialize())
    , _thread("EngineInitializationThread")
    , _reconnectionThread("ReconnectionThread")
{
    numInstances++;

    _engine = std::make_unique<AudioEngine>("novonotes.sonora-app-bridge.v1",
                                            "Sonora App Bridge", true);
    _handler = std::make_unique<ProtoMessageHandler>(*_engine);
    _client = std::make_unique<SocketClient>(*_handler);
    _udpChannel = std::make_unique<UdpChannel>(*_handler);

    _handler->setDelegates(_client.get(), _udpChannel.get(), _udpChannel.get());

    // Logger の設定
    if(numInstances == 1)
    {
        auto logFile = novonotes::getLogFile(getName());
        logFile.getParentDirectory().createDirectory();

        auto *logger = new Logger(logFile, true);
        juce::Logger::setCurrentLogger(logger);
    }

    Logger::writeStartUpMessage(getName(), "v" + getVersion());

    // UdpChannelを初期化（ポート0で自動割り当て）
    bool udpStartResult = _udpChannel->startReceiving(0);
    if (udpStartResult) {
        Logger::info("UDP channel started on port " + String(_udpChannel->getBoundPort()));
    } else {
        Logger::error("Failed to start UDP channel");
    }
    
    // 接続状態を監視するタイマーを開始（1秒ごと）
    startTimerHz(1);
}

PluginProcessor::~PluginProcessor()
{
    // Timerを停止
    stopTimer();
    
    // Thread の停止
    if(_thread.isThreadRunning())
    {
        // Engine 初期化処理をキャンセル
        _isLinking.store(false);
        _thread.stopThread(3000);
    }
    
    // 再接続スレッドの停止
    if(_reconnectionThread.isThreadRunning())
    {
        _isLinking.store(false);
        _reconnectionThread.stopThread(3000);
    }

    // 最後のインスタンスを削除するタイミングで Logger のインスタンスを削除
    if(numInstances == 1)
    {
        auto *l = juce::Logger::getCurrentLogger();
        juce::Logger::setCurrentLogger(nullptr);
        delete l;
    }
    numInstances--;
}

void PluginProcessor::prepareToPlay(double sampleRate, int expectedBlockSize)
{
    // 現在の状態を保存
    _currentSampleRate = sampleRate;
    _currentBlockSize = expectedBlockSize;
    _isPrepared = true;

    // On Linux the plugin and prepareToPlay may not be called on the
    // message thread. Engine needs to be created on the message thread so
    // we'll do that now
    callFunctionOnMessageThread([=, this] {
        _engine->getAudioService().prepareToPlay(sampleRate, expectedBlockSize);
        linkWithApp();
    });

    setLatencySamples(expectedBlockSize);
}

void PluginProcessor::processBlock(AudioBuffer<float> &buffer, MidiBuffer &midi)
{
    // 非正規化数の計算はCPU負荷が高く、パフォーマンスに悪影響を与えるため、これを防止。
    ScopedNoDenormals noDenormals;

    // エンジン再構築中はオーディオ処理をスキップ（クラッシュ防止）
    if(_isReconstructing.load())
    {
        buffer.clear();
        return;
    }

    if(!_client || !_client->isConnected() || !_engine)
    {
        buffer.clear();
        return;
    }

    // Update position info
    _engine->getAudioService().synchronisePlayhead(*this);

    // 入力チャンネルよりも多い出力チャンネルをクリア（ゼロ埋め）。
    // 使用されていない出力チャンネルをゼロクリアし、不要なノイズを防止。
    {
        auto totalNumInputChannels = getTotalNumInputChannels();
        auto totalNumOutputChannels = getTotalNumOutputChannels();

        for(auto i = totalNumInputChannels; i < totalNumOutputChannels; ++i)
        {
            buffer.clear(i, 0, buffer.getNumSamples());
        }
    }

    _engine->getAudioService().processBlock(buffer, midi);
}

AudioProcessorEditor *PluginProcessor::createEditor()
{
    return new PluginEditor(*this);
}

bool PluginProcessor::isBusesLayoutSupported(const BusesLayout &layouts) const
{
    if(layouts.getMainOutputChannelSet() != AudioChannelSet::stereo())
        return false;

    if(layouts.getMainOutputChannelSet() != layouts.getMainInputChannelSet())
        return false;
    return true;
}

void PluginProcessor::getStateInformation(MemoryBlock &destData)
{
    ValueTree vt("sonora-app-bridge");
    vt.setProperty("sock-path", _sockPath, nullptr);
    auto sessionId = _client->getSessionId();
    vt.setProperty("session-id", static_cast<int>(sessionId), nullptr);

    MemoryOutputStream stream{destData, false};
    vt.writeToStream(stream);
}

void PluginProcessor::setStateInformation(const void *data, int length)
{
    auto vt = ValueTree::readFromData(data, static_cast<size_t>(length));
    // 前回のセッション再開は未実装。
    // _sockPath = vt.getProperty("sock-path");
    // int sessionId = vt.getProperty("session-id");
    // _client->setSessionId(static_cast<uint16_t>(sessionId));
}

class UDSPathGenerator
{
   public:
    UDSPathGenerator()
    {
        std::random_device rd;
        gen = std::make_unique<std::mt19937>(rd());
    }

    String generate()
    {
        auto const tmpDir = File::getSpecialLocation(File::tempDirectory);
        auto const randomNumber = dist(*gen);

        auto const socketName =
            "audio_engine." + String(randomNumber) + ".sock";

        // TODO: ここでファイルの存在チェックをしたほうがいいかもしれない。
        return tmpDir.getChildFile("novonotes")
            .getChildFile(socketName)
            .getFullPathName();
    }

   private:
    std::unique_ptr<std::mt19937> gen;
    std::uniform_int_distribution<> dist =
        std::uniform_int_distribution<>(0, 99999999);
};

// clang-format off
/*
    エンジンの初期化。
    必ずメインスレッドで実行されるべき。

    以下のシーケンス図は、VSCode の mermaid エクステンションなどで表示可能。

    初期化処理のシーケンス:

    ```mermaid
    sequenceDiagram
    　 participant DAW
        participant Plugin as PluginProcessor
        participant Server as CoreServer

        DAW ->> Plugin: 状態の復元。
        Plugin ->> Server: [未実装] sock path と session id がわかる場合、再接続とセッション再開を試みる。

        opt アドレス不明 or 接続失敗の場合
            Plugin ->> Plugin: 空いているソケットのファイルパスを探す。
            Plugin ->> Server: サブプロセス起動。コマンドライン引数でアドレスを渡す。 
            Server ->> Server: 初期化・ソケットサーバー起動 
            Plugin ->> Server: 利用可能になったか定期的に接続試行して確認 
        end

        Plugin ->> Plugin: 通信開始
        Server ->> Plugin: 状態復元トークンを問い合わせる
    ```

    終了処理シーケンス:
    ```mermaid
    sequenceDiagram
    　 participant DAW
        participant Plugin as PluginProcessor
        participant Server as CoreServer

        DAW ->> Plugin: 状態の取得
        Plugin ->> DAW: sock path, session id, 状態復元トークンを渡す
        DAW ->> Plugin: デストラクタ呼び出し
        Plugin ->> Server: ソケットの close
        Server ->> Server: 1分待っても再接続がなければ終了
    ```

    状態復元トークンは CoreServer 側で変更があるたびに、できるだけ早くプラグイン側に伝えて、常に同期しているようにするべき。
*/
// clang-format on
void PluginProcessor::relaunchApp()
{
    Logger::info("Manual relaunch requested");

    // エンジンを再構築してから新アプリ起動
    reconstructEngine();
    linkWithApp();
}

void PluginProcessor::reconstructEngine()
{
    Logger::info("Starting engine reconstruction");

    // 再構築中フラグを立てる（オーディオ処理を一時停止）
    _isReconstructing.store(true);

    // 既存の接続をリセット
    if(_client && _client->isConnected())
    {
        // 接続を完全に切断
        _client.reset();
    }

    // 全てのコンポーネントを破棄
    _udpChannel.reset();
    _client.reset();
    _handler.reset();
    _engine.reset();

    // 全てのコンポーネントを再構築（初期状態）
    _engine = std::make_unique<AudioEngine>("novonotes.sonora-app-bridge.v1",
                                            "Sonora App Bridge", true);
    _handler = std::make_unique<ProtoMessageHandler>(*_engine);
    _client = std::make_unique<SocketClient>(*_handler);
    _udpChannel = std::make_unique<UdpChannel>(*_handler);

    // Handlerにdelegatesを再設定
    _handler->setDelegates(_client.get(), _udpChannel.get(), _udpChannel.get());

    // UdpChannelを再初期化
    bool udpStartResult = _udpChannel->startReceiving(0);
    if (udpStartResult) {
        Logger::info("UDP channel restarted on port " + String(_udpChannel->getBoundPort()));
    } else {
        Logger::error("Failed to restart UDP channel");
    }

    // prepareToPlayが呼ばれていた場合は再実行
    if(_isPrepared)
    {
        _engine->getAudioService().prepareToPlay(_currentSampleRate, _currentBlockSize);
        setLatencySamples(_currentBlockSize);
    }

    // 再構築完了、オーディオ処理を再開
    _isReconstructing.store(false);

    Logger::info("Engine reconstruction completed");
}

void PluginProcessor::cancelReconnection()
{
    Logger::info("Cancelling reconnection");
    
    // 再接続フラグをクリア
    _isReconnecting.store(false);
    
    // 再接続スレッドを終了
    if(_reconnectionThread.isThreadRunning())
    {
        _reconnectionThread.signalThreadShouldExit();
        _reconnectionThread.waitForThreadToExit(1000);
    }
}

void PluginProcessor::attemptReconnection()
{
    // リンク中に再接続が呼ばれるのはプログラマーのミス
    jassert(!_isLinking.load());
    
    // すでに再接続中の場合は何もしない（冪等性）
    if(_isReconnecting.load())
    {
        return;
    }
    
    _isReconnecting.store(true);  // 再接続フラグのみセット
    
    if(_reconnectionThread.isThreadRunning())
    {
        _reconnectionThread.waitForThreadToExit(1000);
    }
    
    _reconnectionThread.callback = [=, this](Thread &t) {
        Logger::info("Starting reconnection attempt");
        
        const int64 reconnectionTimeout = 15000; // 15秒
        const int reconnectionInterval = 1000;   // 1秒ごとに再試行
        
        while(_isReconnecting.load() && !t.threadShouldExit())
        {
            // タイムアウトチェック
            int64 elapsedTime = Time::currentTimeMillis() - _disconnectionTime.load();
            if(elapsedTime > reconnectionTimeout)
            {
                Logger::info("Reconnection timeout reached (15 seconds)");
                break;
            }
            
            // 既存のソケットパスで再接続を試みる
            if(!_sockPath.isEmpty())
            {
                _client->openConnection(_sockPath.toStdString());
                if(_client->isConnected())
                {
                    Logger::info("Successfully reconnected to application");
                    _isReconnecting.store(false);
                    return;
                }
            }
            
            Thread::sleep(reconnectionInterval);
        }
        
        // 再接続失敗
        Logger::info("Reconnection timed out or was cancelled by user");
        _isReconnecting.store(false);
    };
    
    _reconnectionThread.startThread();
}

void PluginProcessor::linkWithApp()
{
    // すでにエンジン初期化済み
    if(_client && _client->isConnected())
    {
        return;
    }

    // 前回のバックグラウンド処理が終わる前に新たに initializeEngine()
    // が呼び出されてきたとき
    if(_isLinking.load())
    {
        // 前回のバックグラウンド処理がそのまま動いているはずなのでなにもしない
        return;
    }

    _isLinking.store(true);
    _lastFailure.store(LinkFailureReason::None);

    if(_thread.isThreadRunning())
    {
        // ここに到達するのは、スレッドの処理がほとんど完了しているときのみ。
        // なのでここの待機処理もすぐに終了するはず。
        _thread.waitForThreadToExit(10000);
    }

    Logger::info("Initialize engine");

    _thread.callback = [=, this](Thread &) {
        Logger::info("Start background thread");

        Logger::info("Start child process");

        auto const cwd = _settings.getCwd();
        auto const command = _settings.getCommand();
        auto const args = _settings.getArgs();
        const int64 startTime = Time::currentTimeMillis();
        const int64 linkTimeoutMs = 30000; // 全体のリンク試行タイムアウト（30秒）
        
        if (command.isEmpty())
        {
            Logger::error("Abort linking: empty application path.");
            _lastFailure.store(LinkFailureReason::InvalidConfig);
            _isLinking.store(false);
            return;
        }

        juce::File(cwd).setAsCurrentWorkingDirectory();

        UDSPathGenerator udsGen;

        if(_sockPath == "")
        {
            _sockPath = udsGen.generate();
        }

        while(_isLinking.load())
        {
            // 全体タイムアウト判定
            if (Time::currentTimeMillis() - startTime > linkTimeoutMs)
            {
                Logger::error("Linking aborted: overall timeout reached.");
                _lastFailure.store(LinkFailureReason::Timeout);
                _isLinking.store(false);
                return;
            }
            // Build command arguments (command は除く)
            StringArray commandArgs;
            {
                for (juce::String sourcelArg : args)
                {
                    // String interpolation: replace placeholders
                    juce::String interpolated = sourcelArg.replace("$SOCK_PATH", _sockPath);
                    commandArgs.add(interpolated);
                }
            }

            // ProcessLauncher を使用してdetachedモードで起動
            bool const isStarted = ProcessLauncher::launchDetached(command, commandArgs, cwd);
            if(!isStarted)
            {
                Logger::error("Failed to start application");
                _lastFailure.store(LinkFailureReason::LaunchFailed);
                _isLinking.store(false);
                return;
            }

            // アプリ起動状態
            // アプリに接続できるか10秒間だけ試す
            for(int i = 0; i < 10; ++i)
            {
                _client->openConnection(_sockPath.toStdString());
                if(_client->isConnected())
                {
                    break;
                }

                Thread::sleep(1000);

                // 初期化処理が Cancel されていないか確認。
                if(!_isLinking.load())
                {
                    // Cancel の場合
                    // 注: detachedプロセスなので、明示的にkillできない
                    // BeatGen側でタイムアウト処理があることを期待
                    return;
                }

                // 全体タイムアウトの再チェック（待機ループ内）
                if (Time::currentTimeMillis() - startTime > linkTimeoutMs)
                {
                    Logger::error("Linking aborted during wait: overall timeout reached.");
                    _lastFailure.store(LinkFailureReason::Timeout);
                    _isLinking.store(false);
                    return;
                }
            }

            if(_client->isConnected())
            {
                break;
            }

            // 接続できなかった場合
            // 注: detachedプロセスなので、明示的にkillできない
            // BeatGen側で --auto-exit-time によるタイムアウトを期待

            // 現在の uds アドレスではアプリに接続できなかったので uds
            // を変更する
            _sockPath = udsGen.generate();
        }

        _isLinking.store(false);
    };

    _thread.startThread();
}

PluginProcessor::ConnectionStatus PluginProcessor::getConnectionStatus() const
{
    // 実際の接続状態を確認
    if(_client && _client->isConnected())
    {
        return ConnectionStatus::Connected;
    }
    
    // 再接続中の場合
    if(_isReconnecting.load())
    {
        return ConnectionStatus::Reconnecting;
    }
    
    // リンク中の場合（アプリ起動＆接続）
    if(_isLinking.load())
    {
        return ConnectionStatus::Linking;
    }
    
    return ConnectionStatus::Disconnected;
}

void PluginProcessor::timerCallback()
{
    // リンク中または再接続中の場合はチェック不要
    if(_isLinking.load() || _isReconnecting.load())
    {
        return;
    }
    
    // 前回接続していたが現在切断されている場合
    static bool wasConnected = false;
    bool isConnected = _client && _client->isConnected();
    
    if(wasConnected && !isConnected)
    {
        // 切断を検知
        Logger::info("Connection lost, reconstructing engine then attempting reconnection...");
        _disconnectionTime.store(Time::currentTimeMillis());

        // エンジンを再構築してから再接続を試みる
        reconstructEngine();
        attemptReconnection();
    }
    
    wasConnected = isConnected;
}

}  // namespace novonotes
//==============================================================================
// This creates new instances of the plugin..
juce::AudioProcessor *JUCE_CALLTYPE createPluginFilter()
{
    return new novonotes::PluginProcessor();
}
