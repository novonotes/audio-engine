#include "SocketClient.h"

// clang-format off

#ifdef _WIN32
#define _WIN32_WINNT 0x0A00  // Windows 10 or higher
#include <winsock2.h>
#include <afunix.h>
#include <ws2tcpip.h>
#pragma comment(lib, "Ws2_32.lib")
#else
#include <errno.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#endif

#include <cstring>

// clang-format on

namespace novonotes
{

#ifdef _WIN32
using SocketType = SOCKET;
const SocketType INVALID_SOCKET_VALUE = INVALID_SOCKET;
#define SOCKET_ERROR_VALUE SOCKET_ERROR
class WSAInitializer
{
   public:
    WSAInitializer()
    {
        WSADATA wsaData;
        int result = WSAStartup(MAKEWORD(2, 2), &wsaData);
        if(result != 0)
        {
            throw std::runtime_error("WSAStartup failed");
        }
    }
    ~WSAInitializer() { WSACleanup(); }
};
#else
using SocketType = int;
const SocketType INVALID_SOCKET_VALUE = -1;
#define SOCKET_ERROR_VALUE (-1)
#endif

// 共通のエラー文字列取得関数
static juce::String errorToString(int errCode)
{
#ifdef _WIN32
    char* msgBuffer = nullptr;

    // エラーコードを人間が読めるメッセージに変換
    FormatMessageA(
        FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM |
            FORMAT_MESSAGE_IGNORE_INSERTS,
        nullptr, static_cast<DWORD>(errCode),
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),  // デフォルトの言語
        reinterpret_cast<LPSTR>(&msgBuffer), 0, nullptr);

    juce::String result;
    if(msgBuffer)
    {
        result = juce::String{msgBuffer};
        LocalFree(msgBuffer);  // バッファの解放
    }
    else
    {
        // メッセージが取得できなかった場合はエラーコードを表示
        result = juce::String{"Unknown error code: "} +
                 juce::String{std::to_string(errCode)};
    }

    return result;
#else
    return juce::String{strerror(errCode)};
#endif
}

static int getLastError()
{
#ifdef _WIN32
    return WSAGetLastError();
#else
    return errno;
#endif
}

#ifdef _WIN32
const int ERROR_EBADF = WSAEBADF;
#else
const int ERROR_EBADF = EBADF;
#endif

// クロスプラットフォーム用のヘルパー関数
static void closeSocket(SocketType socket)
{
#ifdef _WIN32
    ::closesocket(socket);
#else
    close(socket);
#endif
}

SocketClient::SocketClient(ProtoMessageHandler& m)
    : _thread("recv thread")
    , _messageHandler(m)
{
#ifdef _WIN32
    static WSAInitializer wsaInit;
#endif
}

SocketClient::~SocketClient()
{
    if(_isConnected.load())
    {
        _isConnected.store(false);
        closeSocket(_fd);
    }
    bool result = _thread.stopThread(1000);
    if(!result)
    {
        juce::Logger::writeToLog("Socket client thread was killed by force.");
    }
}

void SocketClient::openConnection(std::string socketPath)
{
    sockaddr_un addr;
    _fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if(_fd == INVALID_SOCKET_VALUE)
    {
        juce::Logger::writeToLog("failed to create socket: " +
                                 errorToString(getLastError()));
        return;
    }

    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, socketPath.c_str(), sizeof(addr.sun_path) - 1);

    int ret_code = connect(_fd, (sockaddr*)&addr, sizeof(addr));
    if(ret_code == SOCKET_ERROR_VALUE)
    {
        juce::Logger::writeToLog("failed to open socket: " +
                                 errorToString(getLastError()));
        _isConnected.store(false);
        closeSocket(_fd);
        return;
    }

    _isConnected.store(true);

    // 接続が確立したら、NAM のハンドシェイクメッセージ INIT　を送る。
    {
        std::array<uint8_t, 0> empty_body{};
        std::array<uint8_t, 0> empty_context{};
        sendMessage(0, 0, empty_body.data(), 0, empty_context.data());
        juce::Logger::writeToLog("Sent handshake message INIT to server.");
    }

    _thread.callback = [&](auto& t) { loop(t); };
    _thread.startThread();
}

bool SocketClient::isConnected() { return _isConnected.load(); }

bool SocketClient::setSessionId(uint16_t newId)
{
    if(_isConnected.load())
    {
        return false;
    }
    _sessionId = newId;
    return true;
}

void SocketClient::afterDisconnected()
{
    _isConnected.store(false);
    closeSocket(_fd);
    juce::Logger::writeToLog("Socket closed");
}

void SocketClient::loop(juce::Thread& t)
{
    while(!t.threadShouldExit())
    {
        if(!_isConnected.load()) break;

        std::array<uint8_t, nam::MessageDescriptor::SIZE> descriptor_buf;
        int size =
            (int)recv(_fd, reinterpret_cast<char*>(descriptor_buf.data()),
                      nam::MessageDescriptor::SIZE, MSG_WAITALL);

        if(size == 0)
        {
            juce::Logger::writeToLog("Connection closed by peer.");
            break;
        }
        else if(size == SOCKET_ERROR_VALUE)
        {
            int errorCode = getLastError();
            // recv がブロッキング呼び出しのため、closeSocket 実行時に EBADF
            // のエラーが発生する。
            if(errorCode == ERROR_EBADF && !_isConnected.load())
            {
                break;
            }
            juce::Logger::writeToLog("error: recv return SOCKET_ERROR: " +
                                     errorToString(errorCode));
            break;
        }

        nam::MessageDescriptor descriptor(descriptor_buf);
        uint32_t context_size = descriptor.getContextSize();
        std::vector<uint8_t> context_buf(context_size);

        if(context_size > 0)
        {
            size = (int)recv(_fd, reinterpret_cast<char*>(context_buf.data()),
                             context_size, MSG_WAITALL);
            if(size == 0)
            {
                juce::Logger::writeToLog("recv return 0");
                break;
            }
            else if(size == SOCKET_ERROR_VALUE)
            {
                juce::Logger::writeToLog("error: recv return SOCKET_ERROR: " +
                                         errorToString(getLastError()));
                break;
            }
        }

        uint32_t content_size = descriptor.getBodySize();
        auto content_buf = std::vector<uint8_t>(content_size);

        if(content_size > 0)
        {
            size = (int)recv(_fd, reinterpret_cast<char*>(content_buf.data()),
                             content_size, MSG_WAITALL);
            if(size == 0)
            {
                juce::Logger::writeToLog("recv return 0");
                break;
            }
            else if(size == SOCKET_ERROR_VALUE)
            {
                juce::Logger::writeToLog("error: recv return SOCKET_ERROR: " +
                                         errorToString(getLastError()));
                break;
            }
        }

        handleMessage(descriptor, content_buf.data(), content_buf.size(),
                      context_buf.data(), context_buf.size());
    }
    afterDisconnected();
}

void SocketClient::handleMessage(const nam::MessageDescriptor& descriptor,
                                 uint8_t const* body, size_t body_size,
                                 uint8_t const* context, size_t context_size)
{
    jassert(descriptor.getVersion() == 0);

    auto bodyType = descriptor.getBodyType();

    // NAM のハンドシェイク。サーバーからの ACK メッセージ。
    if(bodyType == 0)
    {
        juce::Logger::writeToLog("Received handshake message ACK from server.");

        _sessionId = descriptor.getSessionId();
        juce::Logger::writeToLog("session: " + juce::String(_sessionId));

        // server に RDY を返す。
        {
            std::array<uint8_t, 0> empty_content{};
            std::array<uint8_t, 0> empty_context{};
            sendMessage(0, 0, empty_content.data(), 0, empty_context.data());
            juce::Logger::writeToLog("Sent handshake message RDY to server.");
        }
        _handshakeCompleted = true;
        return;
    }

    if(_handshakeCompleted == false)
    {
        jassertfalse;
        return;
    }

    jassert(descriptor.getSessionId() == _sessionId);

    std::vector<uint8_t> body_copy(body, body + body_size);
    std::vector<uint8_t> context_copy(context, context + context_size);
    juce::MessageManager::callAsync(
        [this, bodyType, body_copy, context_copy]() {
            _messageHandler.handleMessage(bodyType, body_copy.size(),
                                          body_copy.data(), context_copy.size(),
                                          context_copy.data());
        });
}

void SocketClient::sendMessage(uint16_t bodyType, size_t bodySize,
                               const uint8_t* body, size_t contextSize,
                               const uint8_t* context)
{
    std::vector<uint8_t> messageBuf = nam::createMessageBuffer(
        _sessionId, bodyType, bodySize, body, contextSize, context);

    int sentSize =
        (int)send(_fd, reinterpret_cast<const char*>(messageBuf.data()),
                  static_cast<size_t>(messageBuf.size()), 0);
    if(sentSize == SOCKET_ERROR_VALUE)
    {
        juce::Logger::writeToLog("Error sending message: " +
                                 errorToString(getLastError()));
    }
}

}  // namespace novonotes
