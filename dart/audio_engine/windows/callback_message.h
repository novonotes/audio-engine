#pragma once

class ICallbackMessage
{
   public:
    virtual void invoke() = 0;
    virtual void release() = 0;
};

#define WM_USER_NOVONOTES_CALLBACK_MESSAGE (WM_APP + 1000)