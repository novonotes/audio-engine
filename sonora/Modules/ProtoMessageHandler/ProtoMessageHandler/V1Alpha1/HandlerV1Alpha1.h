#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Common/Errors.h>
#include <google/protobuf/struct.pb.h>

#include <cstdint>
#include <vector>

#include "ProtoMessageHandler/Delegates.h"
#include "ProtoMessageHandler/RtSessionManager.h"
#include "ProtoMessageHandler/Utils/ProtoToJson.h"
#include "ProtoMessageHandler/V1Alpha1/PbConverter.h"

namespace novonotes
{

class HandlerV1Alpha1
{
   public:
    HandlerV1Alpha1(AudioEngine& e, RtSessionManager& s,
                    DeviceInstancePbConverter& d)
        : _engine(e)
        , _sessionManager(s)
        , _deviceInstancePbConverter(d)
    {}

    void handleMessage(uint16_t bodyType, size_t contentSize,
                       uint8_t const* data, size_t contextSize,
                       uint8_t const* contextData);

    void setDelegates(DispatchDelegate* dd, RtCommandEndpointDelegate* rced)
    {
        _dispatcher = dd;
        _commandEndpointProvider = rced;
    }

   private:
    AudioEngine& _engine;
    DispatchDelegate* _dispatcher = nullptr;
    RtSessionManager& _sessionManager;
    RtCommandEndpointDelegate* _commandEndpointProvider;
    DeviceInstancePbConverter& _deviceInstancePbConverter;

    void handleMessageImpl(uint16_t bodyType, size_t contentSize,
                           uint8_t const* data,
                           const google::protobuf::Struct& context);
    void sendErrorMessage(const Error&,
                          const google::protobuf::Struct& context);

    template <typename T>
    T deserializePbMessage(uint8_t const* data, size_t contentSize)
    {
        T request;
        auto result =
            request.ParseFromArray(data, static_cast<int>(contentSize));

        if(result == false)
        {
            throw InvalidArgumentError("Context Message Parsing Failed");
        }
        juce::Logger::writeToLog(request.GetTypeName());
        juce::Logger::writeToLog(protoToJsonString(request));
        return request;
    }
};

}  // namespace novonotes
