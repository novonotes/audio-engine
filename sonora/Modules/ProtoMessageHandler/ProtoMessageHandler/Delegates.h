
#pragma once

#include <juce_core/juce_core.h>

#include <cstdint>
#include <vector>

#include "Endpoint.h"
#include "Utils/ProtoToJson.h"

namespace novonotes
{

///  実際のメッセージの送信を委譲する先のクラスの抽象インターフェース。
///  DispatchDelegate の実装は、FFIで他の言語の関数を呼び出したり、Socket
///  通信で他プロセスにメッセージを送ったりするかもしれない。
class DispatchDelegate
{
   public:
    virtual ~DispatchDelegate() = default;

    // メッセージを送信する純粋仮想メソッド
    virtual void sendMessage(uint16_t bodyType, size_t bodySize,
                             const uint8_t* bodyPtr, size_t contextSize,
                             const uint8_t* contextPtr) = 0;

    template <typename Body, typename Context>
    void sendMessage(const Body& body, uint16_t bodyType,
                     const Context& context)
    {
        // メッセージをシリアライズしてバイト配列に変換
        std::string serializedBody;
        body.SerializeToString(&serializedBody);

        std::string serializedContext;
        context.SerializeToString(&serializedContext);

        // Log
        juce::Logger::writeToLog(body.GetTypeName());
        juce::Logger::writeToLog(protoToJsonString(body));

        // メッセージを送信
        size_t bodySize = serializedBody.size();
        size_t contextSize = serializedContext.size();
        const uint8_t* bodyData =
            reinterpret_cast<const uint8_t*>(serializedBody.data());
        const uint8_t* contextData =
            reinterpret_cast<const uint8_t*>(serializedContext.data());

        sendMessage(bodyType, bodySize, bodyData, contextSize, contextData);
    }
};

/// Realtime データを扱う DispatchDelegate
class RtDispatchDelegate
{
   public:
    virtual ~RtDispatchDelegate() = default;
    virtual void sendMessage(const juce::String& remoteHostname,
                             int remotePortNumber, uint32_t sessionId,
                             uint32_t bodyType, const void* bodyData,
                             size_t bodySize) = 0;
};

class RtCommandEndpointDelegate
{
   public:
    virtual ~RtCommandEndpointDelegate() = default;
    /// RtCommand を受け付けている endpoint の情報を返す。
    virtual Endpoint getCommandReceiverEndpoint() = 0;
};
}  // namespace novonotes
