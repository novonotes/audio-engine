#pragma once

#include <Nam/Nam.h>
#include <ProtoMessageHandler/Delegates.h>
#include <dart_api_dl.h>
#include <juce_core/juce_core.h>

namespace novonotes
{
/// FFI を用いて Dart の Port にメッセージを送るクラス
class DartPortMessageSender : public DispatchDelegate
{
   public:
    DartPortMessageSender(Dart_Port dartPortId) : _dartPortId(dartPortId) {}

    void sendMessage(uint16_t bodyType, size_t bodySize, const uint8_t *bodyPtr,
                     size_t contextSize, const uint8_t *contextPtr) override
    {
        std::vector<uint8_t> messageBuf = nam::createMessageBuffer(
            sessionId, bodyType, bodySize, bodyPtr, contextSize, contextPtr);

        Dart_CObject cObject;
        cObject.type = Dart_CObject_kTypedData;
        cObject.value.as_typed_data.type = Dart_TypedData_kUint8;
        cObject.value.as_typed_data.length =
            static_cast<intptr_t>(messageBuf.size());
        cObject.value.as_typed_data.values = messageBuf.data();

        // The function is thread-safe; you can call it anywhere in your C++
        // code
        bool result = Dart_PostCObject_DL(_dartPortId, &cObject);
        assert(result == true);
    }

    uint16_t sessionId = static_cast<uint16_t>(0);

   private:
    Dart_Port _dartPortId;
};
}  // namespace novonotes
