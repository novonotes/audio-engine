#pragma once
#include <juce_events/juce_events.h>
namespace novonotes
{

/** 任意の処理をクラス外から Callback で設定できるタイマークラス
 */
class CallbackTimer : public juce::Timer
{
   public:
    /** タイマーによって呼び出されるコールバック。
        このコールバックの引数には、タイマーを起動した CallbackTimer
       自身の参照が渡される。
        @pre timerCallback()
       が呼び出されるよりも前に有効な関数がセットされること。
        @note
       タイマーの実行中に別のスレッドからこの変数が書き換えられないように注意すること。
    */
    std::function<void(CallbackTimer &)> callback;

   private:
    void timerCallback() override
    {
        jassert(callback != nullptr);
        callback(*this);
    }
};
}  // namespace novonotes
