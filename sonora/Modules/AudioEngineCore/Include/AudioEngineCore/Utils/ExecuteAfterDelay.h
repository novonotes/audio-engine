#pragma once

#include <juce_core/juce_core.h>
#include <juce_events/juce_events.h>

class DelayedExecutor : private juce::Timer
{
   public:
    DelayedExecutor(std::function<void()> callback, int delayMs)
        : _callback(std::move(callback))
    {
        startTimer(delayMs);
    }

    ~DelayedExecutor() override { stopTimer(); }

   private:
    void timerCallback() override
    {
        stopTimer();
        if(_callback) _callback();
        delete this;  // 自動的にオブジェクトを破棄
    }

    std::function<void()> _callback;
};

/// [delayMs] ms 後に処理を実行するための関数
inline void executeAfterDelay(std::function<void()> callback, int delayMs)
{
    // DelayedExecutorは自動的に解放されるよう設計されています
    new DelayedExecutor(std::move(callback), delayMs);
}
