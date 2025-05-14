#include <AudioDeviceManager/AudioDeviceManager.h>
#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Utils/GetProcessId.h>
#include <AudioEngineCore/Utils/LogFile.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <SocketIo/SocketClient.h>
#include <SocketIo/UdpChannel.h>
#include <juce_core/juce_core.h>
#include <signal.h>

namespace novonotes
{
/**
 * @brief Main application class for the Audio Engine Service.
 *
 * This class handles the lifecycle of the audio engine application,
 * including initialization, running, and shutdown.
 */
class MainApplication : public juce::JUCEApplication
{
   public:
    // JUCE application overrides
    const juce::String getApplicationName() override
    {
        return "Audio Engine Service";
    }
    const juce::String getApplicationVersion() override { return "0.1.0"; }
    bool moreThanOneInstanceAllowed() override
    {
        // 統合テストを並列実行するために、複数インスタンスを許可しているが、
        // 実際に複数立ち上げると先に存在していたエンジンの音が出なくなってしまう。
        // おそらく、中で使っている TracktionEngine の仕様っぽい。
        return true;
    }
    const juce::String invalidArgumentErrorMessage =
        "Error: Unexpected command line arguments. Expected: "
        "[--unix-socket, $PATH, --session-id, $SESSION_ID]";

    void initialise(const juce::String& commandLine) override
    {
        std::cout << getApplicationName() + " v" + getApplicationVersion()
                  << std::endl;
        // コマンドライン引数の解析
        juce::StringArray args;
        args.addTokens(commandLine, true);
        if(args.size() < 2 || args[0] != "--unix-socket" ||
           args[2] != "--session-id")
        {
            DBG(invalidArgumentErrorMessage);
            std::cerr << invalidArgumentErrorMessage << std::endl;
            setApplicationReturnValue(2);
            quit();
            return;
        }

        const auto socketPath = args[1].toStdString();
        const int sessionId = args[3].getIntValue();

        // Logger のセットアップ
        setupLogger();

        // SIGTERMハンドラの設定
        signal(SIGTERM, MainApplication::handleSigTerm);

        // コンポーネントの初期化
        _engine = std::make_unique<AudioEngine>(
            "novonotes.audio-engine-service.v1", "Audio Engine Service", false);
        _deviceManager = std::make_unique<AudioDeviceManager>(*_engine);
        _messageHandler = std::make_unique<ProtoMessageHandler>(*_engine);

        _socketClient = std::make_unique<SocketClient>(*_messageHandler);
        _udpChannel = std::make_unique<UdpChannel>(*_messageHandler);
        _messageHandler->setDelegates(_socketClient.get(), _udpChannel.get(),
                                      _udpChannel.get());
        _socketClient->setSessionId(static_cast<uint16_t>(sessionId));
        _socketClient->openConnection(socketPath);

        _udpChannel->startReceiving(0);

        DBG("Initialise operation succeeded.");
    }

    void shutdown() override
    {
        DBG("Shutting down...");

        juce::Logger::writeToLog("Exit");

        // Dispose components
        _deviceManager.reset();
        _engine.reset();
        _socketClient.reset();
        _messageHandler.reset();
        _udpChannel.reset();

        // Clean up logger
        auto* l = juce::Logger::getCurrentLogger();
        juce::Logger::setCurrentLogger(nullptr);
        delete l;

        DBG("Shutdown operation succeeded.");
    }

    void unhandledException(const std::exception* exception,
                            const juce::String& sourceFilename,
                            int lineNumber) override
    {
        juce::String errorMessage = "Unhandled exception: ";

        if(exception != nullptr)
        {
            errorMessage += exception->what();
        }
        else
        {
            errorMessage += "Unknown exception";
        }

        errorMessage += "\nFile: " + sourceFilename;
        errorMessage += "\nLine: " + juce::String(lineNumber);

        // ログにエラーメッセージを書き込む
        juce::Logger::writeToLog(errorMessage);

        // コンソールにエラーメッセージを出力する
        std::cerr << errorMessage << std::endl;

        // アプリケーションを終了する
        juce::JUCEApplication::getInstance()->quit();
    }

   private:
    std::unique_ptr<AudioDeviceManager> _deviceManager;
    std::unique_ptr<AudioEngine> _engine;
    std::unique_ptr<SocketClient> _socketClient;
    std::unique_ptr<ProtoMessageHandler> _messageHandler;
    std::unique_ptr<UdpChannel> _udpChannel;

    /**
     * @brief Set up the application logger.
     *
     * Configures and initializes the logger for the application.
     */
    void setupLogger()
    {
        juce::File logFile = getLogFile(getApplicationName());

        // 必要に応じてディレクトリを作成
        logFile.getParentDirectory().createDirectory();
        auto* logger = new Logger(logFile);
        juce::Logger::setCurrentLogger(logger);
        Logger::writeStartUpMessage(getApplicationName(),
                                    "v" + getApplicationVersion());
    }

    static void handleSigTerm(int)
    {
        DBG("Received SIGTERM signal.");
        juce::Logger::writeToLog("Received SIGTERM signal.");
        juce::JUCEApplication::getInstance()->quit();
    }
};
}  // namespace novonotes

START_JUCE_APPLICATION(novonotes::MainApplication)
