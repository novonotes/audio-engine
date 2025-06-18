#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Common/Errors.h>

#include <cstdint>
#include <vector>

#include "ProtoMessageHandler/Delegates.h"
#include "ProtoMessageHandler/RtCommandHandler.h"
#include "ProtoMessageHandler/RtSessionManager.h"
#include "ProtoMessageHandler/RtStateBroadcaster.h"
#include "ProtoMessageHandler/Utils/ProtoToJson.h"
#include "ProtoMessageHandler/V1Alpha1/HandlerV1Alpha1.h"

namespace novonotes
{

class ProtoMessageHandler
{
   public:
    ProtoMessageHandler(AudioEngine& e)
        : _sessionManager()
        , _rtCommandHandler(e)
        , _stateBroadcaster(e, _sessionManager)
        , _deviceInstancePbConverter(e.getStudioService())
        , _handlerV1Alpha1(e, _sessionManager, _deviceInstancePbConverter)

    {}

    void handleMessage(uint16_t bodyType, size_t contentSize,
                       uint8_t const* data, size_t contextSize,
                       uint8_t const* contextData)
    {
        // TODO: handler の分割
        _handlerV1Alpha1.handleMessage(bodyType, contentSize, data, contextSize,
                                       contextData);
    }

    void setDelegates(DispatchDelegate* dd, RtCommandEndpointDelegate* rced,
                      RtDispatchDelegate* rdd)
    {
        assert(dd != nullptr);
        assert(rced != nullptr);
        assert(rdd != nullptr);

        _stateBroadcaster.setDelegates(rdd);
        _handlerV1Alpha1.setDelegates(dd, rced);

        // delegate が set された後で broadcaster の開始。
        _stateBroadcaster.start();
    }

    void handleRtCommand(uint16_t sessionId, uint16_t bodyType, size_t bodySize,
                         uint8_t const* bodyData, size_t contextSize,
                         uint8_t const* contextData)
    {
        _rtCommandHandler.handleRtCommand(sessionId, bodyType, bodySize,
                                          bodyData, contextSize, contextData);
    }

   private:
    RtSessionManager _sessionManager;
    RtCommandHandler _rtCommandHandler;
    RtStateBroadcaster _stateBroadcaster;
    DeviceInstancePbConverter _deviceInstancePbConverter;
    HandlerV1Alpha1 _handlerV1Alpha1;
};

}  // namespace novonotes
