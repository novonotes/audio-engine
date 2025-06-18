
#pragma once

/// コールバック関数をスレッド間で転送するためのメッセージ
class ICallbackMessage
{
   public:
    virtual void invoke() = 0;
    virtual void release() = 0;
};

template <class F>
class CallbackMessageImpl : public ICallbackMessage
{
   public:
    CallbackMessageImpl(F func) : func_(func) {}

    void invoke() override { func_(); }
    void release() override { delete this; }

   private:
    F func_;
};

template <class Func>
ICallbackMessage *createCallbackMessage(Func f)
{
    return new CallbackMessageImpl<Func>(f);
}

#define WM_USER_NOVONOTES_CALLBACK_MESSAGE (WM_APP + 1000)