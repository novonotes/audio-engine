#pragma once

#include <juce_core/juce_core.h>
#include <juce_gui_basics/juce_gui_basics.h>

#include <future>

#include "State.h"
#include "StatusCode.h"

namespace novonotes
{

class MessageLoopThread : public juce::Thread
{
   public:
    MessageLoopThread(void (*onReady)(intptr_t))
        : juce::Thread("MessageLoopThread")
        , _onReady(onReady)
    {}

    void run() override
    {
        juce::ScopedJuceInitialiser_GUI initializer{};

        auto* instance = juce::MessageManager::getInstance();
        instance->setCurrentThreadAsMessageThread();

        // メッセージループスレッドの準備が整ったことを通知
        g_apiState.store(State::MESSAGE_MANAGER_INITIALIZED);
        _onReady(StatusCodes::SUCCESS);

        // メッセージループを実行
        instance->runDispatchLoop();
    }

   private:
    void (*_onReady)(intptr_t);
};

}  // namespace novonotes
