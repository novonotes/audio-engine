#pragma once
#include <juce_core/juce_core.h>
namespace novonotes
{
//! 外から callback を渡すことで挙動を設定可能な juce::Thread クラス
struct CallbackThread : juce::Thread
{
    //! コンストラクタ
    explicit CallbackThread(juce::StringRef threadName)
        : juce::Thread(threadName)
    {}

    //! スレッド起動時に呼び出されるコールバック。
    /*! @pre run() 関数が呼び出されるより先に有効な値がセットされていること。
     *  @note スレッド実行中にこの変数の値を変更しないこと。
     */
    std::function<void(CallbackThread &)> callback;

   private:
    void run() override
    {
        jassert(callback);
        callback(*this);
    }
};
}  // namespace novonotes
