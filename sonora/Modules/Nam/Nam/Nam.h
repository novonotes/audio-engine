/*
    Packages/AudioEngine/doc/nam.md を参照
*/

#pragma once

#include <array>
#include <cstdint>
#include <memory>
#include <vector>

namespace nam
{
class MessageDescriptor
{
    uint8_t version;
    uint16_t sessionId;
    uint16_t bodyType;
    uint32_t contextSize;
    uint32_t bodySize;

   public:
    static constexpr size_t SIZE = 13;
    MessageDescriptor(std::array<uint8_t, SIZE> buffer);
    MessageDescriptor(uint8_t version, uint16_t sessionId, uint16_t bodyType,
                      uint32_t contextSize, uint32_t bodySize);

    uint8_t getVersion() const;
    uint16_t getSessionId() const;
    uint16_t getBodyType() const;
    uint32_t getBodySize() const;
    uint32_t getContextSize() const;

    void writeToBuffer(uint8_t* data);
};

inline MessageDescriptor::MessageDescriptor(std::array<uint8_t, SIZE> buffer)
{
    version = buffer[0];
    sessionId = buffer[1] << 8 | buffer[2];
    bodyType = buffer[3] << 8 | buffer[4];
    contextSize =
        buffer[5] << 24 | buffer[6] << 16 | buffer[7] << 8 | buffer[8];
    bodySize =
        buffer[9] << 24 | buffer[10] << 16 | buffer[11] << 8 | buffer[12];
}

inline MessageDescriptor::MessageDescriptor(uint8_t v, uint16_t si, uint16_t bt,
                                            uint32_t cs, uint32_t bs)
{
    version = v;
    sessionId = si;
    bodyType = bt;
    contextSize = cs;
    bodySize = bs;
}

inline void MessageDescriptor::writeToBuffer(uint8_t* data)
{
    data[0] = version;
    data[1] = sessionId >> 8;
    data[2] = sessionId & 0xFF;
    data[3] = bodyType >> 8;
    data[4] = bodyType & 0xFF;
    data[5] = contextSize >> 24;
    data[6] = (contextSize >> 16) & 0xFF;
    data[7] = (contextSize >> 8) & 0xFF;
    data[8] = contextSize & 0xFF;
    data[9] = bodySize >> 24;
    data[10] = (bodySize >> 16) & 0xFF;
    data[11] = (bodySize >> 8) & 0xFF;
    data[12] = bodySize & 0xFF;
}

inline uint8_t MessageDescriptor::getVersion() const { return version; }
inline uint16_t MessageDescriptor::getSessionId() const { return sessionId; }
inline uint16_t MessageDescriptor::getBodyType() const { return bodyType; }
inline uint32_t MessageDescriptor::getBodySize() const { return bodySize; }
inline uint32_t MessageDescriptor::getContextSize() const
{
    return contextSize;
}

/// メッセージバッファを作成する関数
static inline std::vector<uint8_t> createMessageBuffer(
    uint16_t sessionId, uint16_t bodyType, size_t bodySize, const void* bodyPtr,
    size_t contextSize, const void* contextPtr)
{
    size_t messageSize = bodySize + contextSize + MessageDescriptor::SIZE;
    std::vector<uint8_t> messageBuf(messageSize);

    MessageDescriptor descriptor(0, sessionId, bodyType,
                                 static_cast<uint32_t>(contextSize),
                                 static_cast<uint32_t>(bodySize));
    descriptor.writeToBuffer(messageBuf.data());

    if(contextSize != 0)
    {
        std::memcpy(messageBuf.data() + MessageDescriptor::SIZE, contextPtr,
                    contextSize);
    }
    std::memcpy(messageBuf.data() + MessageDescriptor::SIZE + contextSize,
                bodyPtr, bodySize);

    return messageBuf;
}
}  // namespace nam
