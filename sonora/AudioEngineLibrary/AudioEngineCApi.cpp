#include <AudioDeviceManager/AudioDeviceManager.h>
#include <AudioEngineCApi.h>
#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Utils/GetProcessId.h>
#include <AudioEngineCore/Utils/LogFile.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <Nam/Nam.h>
#include <ProtoMessageHandler/ProtoMessageHandler.h>
#include <SocketIo/UdpChannel.h>
#include <dart_api_dl.h>
#include <juce_core/juce_core.h>
#include <juce_gui_basics/juce_gui_basics.h>

#include <cassert>
#include <functional>
#include <iostream>
#include <thread>

#include "CallbackMessage.h"
#include "DartPortMessageSender.h"
#include "MessageManagerPlatformIntegration.h"
#include "State.h"
#include "StatusCode.h"
#include "Utils/GetCurrentThreadId.h"
#include "Utils/GetMainThreadId.h"

// global variables
static std::unique_ptr<novonotes::AudioDeviceManager> g_deviceManager;
static std::unique_ptr<novonotes::AudioEngine> g_engine;
static std::unique_ptr<novonotes::ProtoMessageHandler> g_messageHandler;
static std::unique_ptr<novonotes::DartPortMessageSender> g_sender;
static std::unique_ptr<novonotes::UdpChannel> g_udpChannel;

static std::atomic<int> g_processingMessageCount{0};

static std::string getApplicationName() { return "Audio Engine Library"; }

static std::string getApplicationVersion() { return "0.1.0"; }

static void configureLogger()
{
    // Log の設定
    if(juce::Logger::getCurrentLogger() == nullptr)
    {
        auto logFile = novonotes::getLogFile(getApplicationName());
        logFile.getParentDirectory().createDirectory();

        auto *logger = new novonotes::Logger(logFile);
        juce::Logger::setCurrentLogger(logger);
    }

    novonotes::Logger::writeStartUpMessage(getApplicationName(),
                                           "v" + getApplicationVersion());
    novonotes::Logger::debug("ProcessId:" + juce::String(getProcessId()));
    novonotes::Logger::debug("MainThreadId:" + getMainThreadId());
}

extern "C"
{
    void initDartApi(void *data, int apiVersion, void (*onComplete)(intptr_t))
    {
#if 0
        // デバッグ用機能。これを1にセットすると無限ループが発生して、
        // デバッガをアタッチするタイミングが作れるようになる
        // デバッガでアタッチしたあとで wait 変数の値を false
        // にセットするとループを抜けて処理を続行できる。
        static int wait = true;
        for(;;)
        {
            if(wait == false)
            {
                break;
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
#endif
        if(apiVersion != 0)
        {
            novonotes::Logger::error("Unsupported API Version: " +
                                     juce::String(apiVersion));
            return onComplete(StatusCodes::UNSUPPORTED_API_VERSION);
        }

        if(g_apiState.load() != State::UNINITIALIZED)
        {
            return onComplete(StatusCodes::DART_API_ALREADY_INITIALIZED);
        }

        g_apiState.store(State::DART_API_INITIALIZING);

        configureLogger();

        intptr_t result = Dart_InitializeApiDL(data);
        if(result == 0)
        {
            g_apiState.store(State::DART_API_INITIALIZED);
            return onComplete(StatusCodes::SUCCESS);
        }
        else
        {
            g_apiState.store(State::UNINITIALIZED);
            return onComplete(StatusCodes::UNKNOWN_ERROR);
        }
    }

    void initMessageManager(intptr_t hwnd, void (*onComplete)(intptr_t))
    {
        novonotes::Logger::debug(
            "initMessageManager called. (threadId=" + getCurrentThreadId() +
            ", mainThreadId=" + getMainThreadId() +
            ", hwnd=" + std::to_string(hwnd) + ")");

        // shutdownEngine should be called before initializing the engine again.
        int state = g_apiState.load();
        if(state < State::DART_API_INITIALIZED)
        {
            onComplete(StatusCodes::DART_API_NOT_INITIALIZED);
            return;
        }
        if(state >= State::MESSAGE_MANAGER_INITIALIZING)
        {
            onComplete(StatusCodes::MESSAGE_MANAGER_ALREADY_INITIALIZED);
            return;
        }

        g_apiState = State::MESSAGE_MANAGER_INITIALIZING;
        novonotes::Logger::debug("MessageManager initialization started.");

        // メッセージマネージャーのセットアップ
#if JUCE_WINDOWS
        MessageManagerPlatformIntegration::initialize(hwnd, onComplete);
#else
        MessageManagerPlatformIntegration::initialize(onComplete);
#endif
    }

    void initEngine(int64_t dartPortId, void (*onComplete)(intptr_t))
    {
        novonotes::Logger::debug(
            "initEngine called. (dartPortId=" + juce::String(dartPortId) + ")");

        // shutdownEngine should be called before initializing the engine again.
        int state = g_apiState.load();
        if(state < State::MESSAGE_MANAGER_INITIALIZED)
        {
            novonotes::Logger::info("Message manager not initialized: state=" +
                                    juce::String(state));
            onComplete(StatusCodes::MESSAGE_MANAGER_NOT_INITIALIZED);
            return;
        }
        if(state >= State::ENGINE_INITIALIZING)
        {
            onComplete(StatusCodes::ENGINE_ALREADY_INITIALIZED);
            return;
        }

        g_apiState.store(State::ENGINE_INITIALIZING);
        novonotes::Logger::debug("Starting engine initialization...");

        // Now that the message loop is ready, we can use callAsync
        bool result = juce::MessageManager::getInstance()->callAsync(
            [dartPortId, onComplete]() {
                novonotes::Logger::debug("Engine initialization started.");
                g_engine = std::make_unique<novonotes::AudioEngine>(
                    "novonotes.audio-engine-library.v1",
                    "In-process Audio Engine", false);
                g_deviceManager =
                    std::make_unique<novonotes::AudioDeviceManager>(*g_engine);
                g_sender = std::make_unique<novonotes::DartPortMessageSender>(
                    dartPortId);
                g_messageHandler =
                    std::make_unique<novonotes::ProtoMessageHandler>(*g_engine);
                g_udpChannel =
                    std::make_unique<novonotes::UdpChannel>(*g_messageHandler);
                g_messageHandler->setDelegates(
                    g_sender.get(), g_udpChannel.get(), g_udpChannel.get());
                g_apiState.store(true);

                novonotes::Logger::debug("Engine initialization completed.");

                bool success = g_udpChannel->startReceiving(0);
                if(success == false)
                {
                    onComplete(StatusCodes::ENGINE_NOT_INITIALIZED);
                }

                g_apiState.store(State::ENGINE_INITIALIZED);

                // NAM のハンドシェイクの INIT を送信。
                {
                    std::array<uint8_t, 0> content{};
                    std::array<uint8_t, 0> context{};
                    g_sender->sendMessage(0, 0, content.data(), 0,
                                          context.data());
                }

                return onComplete(StatusCodes::SUCCESS);
            });

        if(!result)
        {
            g_apiState.store(State::MESSAGE_MANAGER_INITIALIZED);
            onComplete(StatusCodes::ASYNC_CALL_FAILED);
            return;
        }
    }

    void shutdownEngine(void (*onComplete)(intptr_t))
    {
        novonotes::Logger::debug("shutdownEngine called.");
        if(g_processingMessageCount.load() != 0)
        {
            onComplete(StatusCodes::MESSAGE_PROCESSING);
            return;
        }
        int state = g_apiState.load();
        if(state < State::ENGINE_INITIALIZED)
        {
            return onComplete(StatusCodes::ENGINE_NOT_INITIALIZED);
        }
        if(state >= State::ENGINE_SHUTTING_DOWN)
        {
            return onComplete(StatusCodes::ENGINE_ALREADY_SHUT_DOWN);
        }

        g_apiState.store(State::ENGINE_SHUTTING_DOWN);

        juce::MessageManager::getInstance()->callFunctionOnMessageThread(
            [](void *) {
                assert(g_processingMessageCount.load() == 0);
                novonotes::Logger::debug("Engine shutdown started.");
                g_messageHandler.reset();
                g_sender.reset();
                g_deviceManager.reset();
                g_engine.reset();
                g_udpChannel.reset();
                return static_cast<void *>(nullptr);
            },
            nullptr);

        g_apiState.store(false);
        novonotes::Logger::debug("Engine shutdown completed.");

        g_apiState.store(State::ENGINE_SHUT_DOWN);
        return onComplete(StatusCodes::SUCCESS);
    }

    void shutdownMessageManager(void (*onComplete)(intptr_t))
    {
        novonotes::Logger::debug("shutdownMessageManager called.");
        if(g_processingMessageCount.load() != 0)
        {
            onComplete(StatusCodes::MESSAGE_PROCESSING);
            return;
        }
        int state = g_apiState.load();
        if(state < State::ENGINE_SHUT_DOWN)
        {
            return onComplete(StatusCodes::ENGINE_NOT_SHUT_DOWN);
        }
        if(state >= State::MESSAGE_MANAGER_SHUTTING_DOWN)
        {
            return onComplete(StatusCodes::MESSAGE_MANAGER_ALREADY_SHUT_DOWN);
        }

        g_apiState.store(State::MESSAGE_MANAGER_SHUTTING_DOWN);
        // メッセージマネージャーのシャットダウン
        MessageManagerPlatformIntegration::shutdown(onComplete);
    }

    void shutdownDartApi(void (*onComplete)(intptr_t))
    {
        novonotes::Logger::debug("shutdownDartApi called.");
        novonotes::Logger::debug("Exit.");

        int state = g_apiState.load();
        if(state < State::MESSAGE_MANAGER_SHUT_DOWN)
        {
            return onComplete(StatusCodes::MESSAGE_MANAGER_NOT_SHUT_DOWN);
        }
        if(state >= State::DART_API_SHUTTING_DOWN)
        {
            return onComplete(StatusCodes::DART_API_ALREADY_SHUT_DOWN);
        }

        g_apiState = State::DART_API_SHUTTING_DOWN;

        // Logger のインスタンスの削除
        {
            auto *l = juce::Logger::getCurrentLogger();
            juce::Logger::setCurrentLogger(nullptr);
            delete l;
        }

        g_apiState = State::UNINITIALIZED;
        return onComplete(StatusCodes::SUCCESS);
    }

    void sendMessageToEngine(unsigned char const *msg, int len,
                             void (*onComplete)(intptr_t))
    {
        g_processingMessageCount++;
        novonotes::Logger::debug(
            "sendMessageToEngine called. (len=" + juce::String(len) +
            ", threadId=" + getCurrentThreadId() + ")");

        if(len < static_cast<int>(nam::MessageDescriptor::SIZE))
        {
            g_processingMessageCount--;
            // メッセージのフォーマットが不正
            return onComplete(StatusCodes::INVALID_MESSAGE_FORMAT);
        }
        if(g_apiState.load() != State::ENGINE_INITIALIZED)
        {
            g_processingMessageCount--;
            // エンジンが初期化されていない場合はエラーコードを返す
            return onComplete(StatusCodes::ENGINE_NOT_RUNNING);
        }
        // メッセージは非同期で処理するので、破棄されないようにコピーしておく
        juce::MemoryBlock msgCopy(msg, static_cast<size_t>(len));
        juce::MessageManager::callAsync([msgCopy, onComplete]() {
            if(g_apiState.load() != State::ENGINE_INITIALIZED)
            {
                g_processingMessageCount--;
                onComplete(StatusCodes::ENGINE_NOT_RUNNING);
                return;
            }

            // Descriptor を取り出す
            std::array<uint8_t, nam::MessageDescriptor::SIZE> descriptor_buf;
            std::copy_n(msgCopy.begin(), nam::MessageDescriptor::SIZE,
                        descriptor_buf.data());
            nam::MessageDescriptor descriptor(descriptor_buf);

            auto bodyType = descriptor.getBodyType();
            auto sessionId = descriptor.getSessionId();

            // NAM のハンドシェイクの ACK メッセージのハンドリング
            if(bodyType == 0)
            {
                novonotes::Logger::debug("Received ACK message. (sessionId=" +
                                         juce::String(sessionId) + ")");

                g_sender->sessionId = sessionId;

                // RDY メッセージを送信。
                {
                    std::array<uint8_t, 0> content{};
                    std::array<uint8_t, 0> context{};
                    g_sender->sendMessage(0, 0, content.data(), 0,
                                          context.data());
                }
                g_processingMessageCount--;
                onComplete(StatusCodes::SUCCESS);
                return;
            }

            jassert(sessionId == g_sender->sessionId);

            uint32_t context_size = descriptor.getContextSize();
            auto context_buf = std::make_unique<uint8_t[]>(context_size);
            if(context_size > 0)
            {
                std::copy_n(msgCopy.begin() + nam::MessageDescriptor::SIZE,
                            context_size, context_buf.get());
            }

            uint32_t content_size = descriptor.getBodySize();
            auto content_buf = std::make_unique<uint8_t[]>(content_size);

            if(content_size > 0)
            {
                std::copy_n(msgCopy.begin() + nam::MessageDescriptor::SIZE +
                                context_size,
                            content_size, content_buf.get());
            }

            g_messageHandler->handleMessage(descriptor.getBodyType(),
                                            content_size, content_buf.get(),
                                            context_size, context_buf.get());
            g_processingMessageCount--;

            return onComplete(StatusCodes::SUCCESS);
        });
    }

    intptr_t dispatchNextJuceMessage()
    {
        auto instance = juce::MessageManager::getInstance();

        // JUCE がメッセージスレッドとして認識しているスレッド以外からは
        // runDispatchLoopUntil() を呼び出せないので、
        // 必ず呼び出し元のスレッドをメッセージスレッドに設定している。
        // （JUCE のソースコードを確認した感じでは dispatchNextJUCEMessage()
        // を呼び出すスレッドが変わらない限り毎回
        // setCurrentThreadAsMessageThread()
        // を呼び出しても特に負荷にはならないはず。
        // Windows の場合はメッセージスレッドを切り替えるときに
        // ダミーのウィンドウを作り直す処理が入るので、
        // スレッドが頻繁に切り替わる場合は負荷になる可能性がある。）
        instance->setCurrentThreadAsMessageThread();

        bool result = instance->runDispatchLoopUntil(0);
        if(!result) return StatusCodes::DISPATCH_MESSAGE_FAILED;

        return StatusCodes::SUCCESS;
    }

    intptr_t getState() { return g_apiState.load(); }
}  // extern "C"
