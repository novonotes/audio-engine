#pragma once

#include <AudioEngineCore/Common/Errors.h>

#include <regex>
#include <string>

namespace novonotes
{
struct Endpoint
{
    enum class Protocol
    {
        UDP,
        TCP,
        UDS,
        NamedPipe,
        WebSocket,
        HTTP,
        HTTPS
    };

    Protocol protocol;
    juce::String address;
    int port = -1;
    // WebSocket/HTTP/HTTPS で利用
    juce::String path = "";

    bool operator==(const Endpoint& other) const
    {
        return protocol == other.protocol && address == other.address &&
               port == other.port && path == other.path;
    }

    /// Endpoint を URL文字列に変換
    juce::String toUrlString() const
    {
        juce::String url;
        switch(protocol)
        {
            case Protocol::UDP:
                url = "udp://";
                break;
            case Protocol::TCP:
                url = "tcp://";
                break;
            case Protocol::UDS:
                url = "uds://";
                break;
            case Protocol::NamedPipe:
                url = "namedpipe://";
                break;
            case Protocol::WebSocket:
                url = "ws://";
                break;
            case Protocol::HTTP:
                url = "http://";
                break;
            case Protocol::HTTPS:
                url = "https://";
                break;
        }

        url += address;

        // UDP/TCP/WebSocket/HTTP/HTTPS でポートがある場合
        if((protocol == Protocol::UDP || protocol == Protocol::TCP ||
            protocol == Protocol::WebSocket || protocol == Protocol::HTTP ||
            protocol == Protocol::HTTPS) &&
           port >= 0)
        {
            url += ":" + juce::String(port);
        }

        // WebSocket/HTTP/HTTPS などで path がある場合
        if(!path.isEmpty() &&
           (protocol == Protocol::WebSocket || protocol == Protocol::HTTP ||
            protocol == Protocol::HTTPS))
        {
            url += path;
        }

        return url;
    }

    /**
     URL をパースして Endpoint を生成します。

     @param url URL文字列 (例: "http://example.com:8080/api")
     @return パースされた Endpoint オブジェクト
     @throws InvalidArgumentError 無効なURLの場合

     使用例:
     - 入力: "http://example.com:8080/api"
     出力: protocol=HTTP, address="example.com", port=8080, path="/api"

     - 入力: "udp://192.168.1.10:5060"
     出力: protocol=UDP, address="192.168.1.10", port=5060, path=""

     - 入力: "uds://some/unix/socket"
     出力: protocol=UDS, address="some/unix/socket", port=-1, path=""

     - 入力: "ws://localhost:1234/chat"
     出力: protocol=WebSocket, address="localhost", port=1234, path="/chat"
     */
    static Endpoint parse(const std::string& url)
    {
        std::regex urlPattern(
            R"((udp|tcp|uds|namedpipe|ws|wss|http|https)://([^:/]+)(?::(\d+))?(.*)?)");
        std::smatch matches;

        if(std::regex_match(url, matches, urlPattern))
        {
            if(matches.size() >= 3)
            {
                Endpoint endpoint;
                juce::String protocolStr(matches[1].str());

                if(protocolStr == "udp")
                    endpoint.protocol = Protocol::UDP;
                else if(protocolStr == "tcp")
                    endpoint.protocol = Protocol::TCP;
                else if(protocolStr == "uds")
                    endpoint.protocol = Protocol::UDS;
                else if(protocolStr == "namedpipe")
                    endpoint.protocol = Protocol::NamedPipe;
                else if(protocolStr == "ws" || protocolStr == "wss")
                    endpoint.protocol = Protocol::WebSocket;
                else if(protocolStr == "http")
                    endpoint.protocol = Protocol::HTTP;
                else if(protocolStr == "https")
                    endpoint.protocol = Protocol::HTTPS;
                else
                    throw InvalidArgumentError("Unsupported protocol");

                endpoint.address = juce::String(matches[2].str());
                if(endpoint.address == "localhost")
                {
                    endpoint.address = "127.0.0.1";
                }

                // ポートが指定される場合 (UDP/TCP/WebSocket/HTTP/HTTPS)
                if((endpoint.protocol == Protocol::UDP ||
                    endpoint.protocol == Protocol::TCP ||
                    endpoint.protocol == Protocol::WebSocket ||
                    endpoint.protocol == Protocol::HTTP ||
                    endpoint.protocol == Protocol::HTTPS) &&
                   matches.size() >= 4 && matches[3].matched)
                {
                    endpoint.port = std::stoi(matches[3].str());
                }

                // UDS の場合は path を使わず address に格納
                if(endpoint.protocol == Protocol::UDS && matches.size() >= 5)
                {
                    endpoint.address += juce::String(matches[4].str());
                }
                // パスが指定される場合 (WebSocket/HTTP/HTTPSなど)
                else if(matches.size() >= 5 && matches[4].matched)
                {
                    endpoint.path = juce::String(matches[4].str());
                }

                return endpoint;
            }
        }

        throw InvalidArgumentError("Invalid URL format");
    }
};
}  // namespace novonotes
