// このファイルを proto ファイルから自動生成する
#pragma once

#include <AudioEngineCore/Utils/CallbackThread.h>
#include <Nam/Nam.h>
#include <ProtoMessageHandler/Delegates.h>
#include <ProtoMessageHandler/ProtoMessageHandler.h>

#include <cstdint>
#include <string>
#include <vector>

namespace novonotes
{

/// UDS に依存しているので、Windows は 10 以降でしか動作しない。
class SocketClient : public DispatchDelegate
{
   public:
    SocketClient(ProtoMessageHandler& handler);
    ~SocketClient();

    void openConnection(std::string socketPath);
    /// 変更できた場合は true
    /// を返す。すでに接続済みなどの理由で、変更できない場合は、false を返す。
    bool setSessionId(uint16_t newId);
    uint16_t getSessionId() { return _sessionId; }
    bool isConnected();
    /// どのスレッドから呼んでも問題ない
    void sendMessage(uint16_t bodyType, size_t contentSize, const uint8_t* data,
                     size_t contextSize, const uint8_t* context);

   private:
    CallbackThread _thread;
    int _fd;
    // 接続が確立した後は true;
    std::atomic<bool> _isConnected;
    ProtoMessageHandler& _messageHandler;
    bool _handshakeCompleted;

    uint16_t _sessionId = 0;

    void loop(juce::Thread&);

    void handleMessage(const nam::MessageDescriptor& descriptor,
                       uint8_t const* body, size_t body_size,
                       uint8_t const* context, size_t context_size);

    void afterDisconnected();
};
}  // namespace novonotes
