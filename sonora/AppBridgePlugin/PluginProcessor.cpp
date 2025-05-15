#include "PluginProcessor.h"

#include <AudioEngineCore/Utils/GetProcessId.h>
#include <AudioEngineCore/Utils/LogFile.h>

#include <random>

#include "PluginDevEditor.h"
#include "Settings/SettingsFile.h"
#include "Utils/JsonUtils.h"

namespace novonotes
{

static int numInstances = 0;

PluginProcessor::PluginProcessor()
    : AudioProcessor(BusesProperties()
                         .withInput("Input", AudioChannelSet::stereo())
                         .withOutput("Output", AudioChannelSet::stereo()))
    , _settings(Settings::initialize())
    , _thread("EngineInitializationThread")
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
}

PluginProcessor::~PluginProcessor()
{
    // Thread の停止
    if(_thread.isThreadRunning())
    {
        // Engine 初期化処理をキャンセル
        _isLinking.store(false);
        _thread.stopThread(3000);
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

    if(!_linkCompleted.load())
    {
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
    return new PluginDevEditor(*this);
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
void PluginProcessor::linkWithApp()
{
    // すでにエンジン初期化済み
    if(_linkCompleted.load())
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
        
        if (command.isEmpty())
        {
            Logger::error("Abort linking: empty application path.");
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
            ChildProcess child;
            
            // Build full command array
            StringArray fullCommand;
            {
                fullCommand.add(command);
                for (juce::String sourcelArg : args)
                {
                    // String interpolation: replace placeholders
                    juce::String interpolated = sourcelArg.replace("$SOCK_PATH", _sockPath);
                    fullCommand.add(interpolated);
                }
            }

            bool const isStarted = child.start(fullCommand, 0);
            if(!isStarted)
            {
                Logger::error("Failed to start application");
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
                if(_isLinking.load() == false)
                {
                    // Cancel の場合、プロセスを明示的に終了
                    child.kill();
                    return;
                }
            }

            if(_client->isConnected())
            {
                break;
            }

            // 接続できなかった場合、プロセスを明示的に終了
            child.kill();

            // 現在の uds アドレスではアプリに接続できなかったので uds
            // を変更する
            _sockPath = udsGen.generate();
        }

        _linkCompleted.store(true);
        _isLinking.store(false);
    };

    _thread.startThread();
}

}  // namespace novonotes
//==============================================================================
// This creates new instances of the plugin..
juce::AudioProcessor *JUCE_CALLTYPE createPluginFilter()
{
    return new novonotes::PluginProcessor();
}
