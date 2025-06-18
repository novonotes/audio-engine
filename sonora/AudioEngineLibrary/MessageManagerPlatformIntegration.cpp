
#include <juce_core/juce_core.h>
#include <juce_gui_basics/juce_gui_basics.h>

#include <cassert>

#if JUCE_MAC || JUCE_IOS
#include <dispatch/dispatch.h>

#include "MessageLoopThread.h"
#elif JUCE_WINDOWS
#include <windows.h>

#include "CallbackMessage.h"
#elif JUCE_LINUX
#include "MessageLoopThread.h"

#endif

#include <AudioEngineCore/Utils/Logger.h>

#include "MessageManagerPlatformIntegration.h"
#include "State.h"
#include "StatusCode.h"

namespace MessageManagerPlatformIntegration
{

#if JUCE_LINUX

static std::unique_ptr<novonotes::MessageLoopThread> g_messageLoopThread;

void initialize(void (*onComplete)(intptr_t))
{
    if(g_messageLoopThread != nullptr)
    {
        assert(false);
        g_apiState.store(State::DART_API_INITIALIZED);
        return onComplete(StatusCodes::MESSAGE_MANAGER_ALREADY_CREATED);
    }
    g_messageLoopThread =
        std::make_unique<novonotes::MessageLoopThread>(onComplete);
    bool result = g_messageLoopThread->startThread();
    if(!result)
    {
        g_apiState.store(State::DART_API_INITIALIZED);
        onComplete(StatusCodes::UNKNOWN_ERROR);
    }
}

void shutdown(void (*onComplete)(intptr_t))
{
    if(g_messageLoopThread == nullptr)
    {
        g_apiState.store(State::ENGINE_SHUT_DOWN);
        return onComplete(StatusCodes::MESSAGE_MANAGER_NOT_EXIST);
    }
    juce::MessageManager::getInstance()->stopDispatchLoop();
    if(!g_messageLoopThread->waitForThreadToExit(4000))  // 最大4秒間待機
    {
        // スレッドが終了しない場合は強制的に停止
        g_messageLoopThread->signalThreadShouldExit();
    }
    g_messageLoopThread.reset();
    g_apiState.store(State::MESSAGE_MANAGER_SHUT_DOWN);
    onComplete(StatusCodes::SUCCESS);
}

#elif JUCE_IOS || JUCE_MAC

static std::unique_ptr<juce::ScopedJuceInitialiser_GUI> g_initializer;

static void executeOnMainThread(std::function<void()> functionToExecute)
{
    dispatch_async(dispatch_get_main_queue(), ^{
      functionToExecute();
    });
}

void initialize(void (*onComplete)(intptr_t))
{
    executeOnMainThread([onComplete] {
        g_initializer = std::make_unique<juce::ScopedJuceInitialiser_GUI>();
        juce::MessageManager::getInstance()->setCurrentThreadAsMessageThread();
        g_apiState = State::MESSAGE_MANAGER_INITIALIZED;
        auto state = g_apiState.load();
        novonotes::Logger::debug("MessageManager initialized. state=" +
                                 juce::String(state));
        onComplete(StatusCodes::SUCCESS);
    });
}

void shutdown(void (*onComplete)(intptr_t))
{
    executeOnMainThread([onComplete] {
        g_initializer.reset();
        g_apiState.store(State::MESSAGE_MANAGER_SHUT_DOWN);
        onComplete(StatusCodes::SUCCESS);
    });
}

#elif JUCE_WINDOWS

static std::unique_ptr<juce::ScopedJuceInitialiser_GUI> g_initializer;
static HWND g_hwnd = nullptr;

using CallbackMessageFunc = void (*)(ICallbackMessage *);

void initialize(intptr_t hwndAddr, void (*onComplete)(intptr_t))
{
    // Windows 環境では、 runner
    // がメッセージループを駆動しているのと同じスレッドを
    // juce::MessageManager
    // のメッセージスレッドとして登録する必要があるようだった。
    // （これをしないと、 callAsync などがうまく動かない）
    // そのため、Top level window の handler を用いて、メインスレッド上で
    // setCurrentThreadAsMessageThread() や ScopedJuceInitialiser_GUI
    // の初期化 を行うようにしている。 flutter test
    // コマンドによるテスト実行時は、Top level window
    // やメッセージループが利用できないため、 dart 側から手動で
    // dispatchNextJUCEMessage を呼び出して駆動する。
    if(hwndAddr == 0)
    {
        novonotes::Logger::debug(
            "HWND is not available. It is needed to call "
            "dispatchNextJUCEMessage periodically.");
        juce::MessageManager::getInstance()->setCurrentThreadAsMessageThread();
        g_initializer = std::make_unique<juce::ScopedJuceInitialiser_GUI>();
        g_apiState.store(State::MESSAGE_MANAGER_INITIALIZED);
        return onComplete(StatusCodes::SUCCESS);
    }

    g_hwnd = reinterpret_cast<HWND>(hwndAddr);
    novonotes::Logger::debug(IsWindow(g_hwnd) ? "HWND is valid."
                                              : "HWND is invalid.");

    auto msg = createCallbackMessage([onComplete] {
        novonotes::Logger::debug(
            "Start initializing MessageManager on main thread.");
        juce::MessageManager::getInstance()->setCurrentThreadAsMessageThread();
        g_initializer = std::make_unique<juce::ScopedJuceInitialiser_GUI>();
        g_apiState.store(State::MESSAGE_MANAGER_INITIALIZED);
        novonotes::Logger::debug("Initializing MessageManager completed.");
        return onComplete(StatusCodes::SUCCESS);
    });
    novonotes::Logger::debug("Calling PostMessage.");
    PostMessage(g_hwnd, WM_USER_NOVONOTES_CALLBACK_MESSAGE, (WPARAM)msg, 0);
}

void shutdown(void (*onComplete)(intptr_t))
{
    if(g_hwnd == nullptr)
    {
        g_initializer.reset();
        g_apiState.store(State::MESSAGE_MANAGER_SHUT_DOWN);
        return onComplete(StatusCodes::SUCCESS);
    }

    auto msg = createCallbackMessage([onComplete] {
        g_initializer.reset();
        g_apiState.store(State::MESSAGE_MANAGER_SHUT_DOWN);
        return onComplete(StatusCodes::SUCCESS);
    });
    novonotes::Logger::debug("Calling PostMessage.");
    PostMessage(g_hwnd, WM_USER_NOVONOTES_CALLBACK_MESSAGE, (WPARAM)msg, 0);
}
#else
#error Unsupported Platform
#endif

}  // namespace MessageManagerPlatformIntegration
