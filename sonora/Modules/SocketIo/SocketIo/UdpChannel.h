#pragma once

#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/Utils/CallbackThread.h>
#include <Nam/Nam.h>
#include <ProtoMessageHandler/Delegates.h>
#include <ProtoMessageHandler/ProtoMessageHandler.h>
#include <assert.h>
#include <juce_core/juce_core.h>

#include <stdexcept>  // 例外用ヘッダ

namespace novonotes
{

/**
 * @brief UDPチャネルクラス
 *
 * このクラスはUDPを用いたコマンドの送受信を管理します。
 */
class UdpChannel
    : public RtDispatchDelegate
    , public RtCommandEndpointDelegate
{
   public:
    /**
     * @brief コンストラクタ
     * @param h メッセージハンドラへの参照
     */
    UdpChannel(ProtoMessageHandler& h)
        : _isStopped(false)
        , _isBound(false)
        , _thread("UDP Receiver Thread")
        , _handler(h)
    {
        _thread.callback = [this](auto&) { read(); };
    }

    /**
     * @brief デストラクタ
     */
    ~UdpChannel() override { stopReceiving(); }

    /**
     * @brief 現在バインドされているポート番号を返す
     * @return バインド済みポート番号
     */
    int getBoundPort() const { return _socket.getBoundPort(); }

    /**
     * @brief コマンド受信用エンドポイントを取得する
     *
     * バインドがまだ行われていない場合は例外（FailedPreconditionError）を投げます。
     *
     * @return エンドポイント情報
     * @throws std::runtime_error バインドが行われていない場合
     */
    Endpoint getCommandReceiverEndpoint() override
    {
        if(!_isBound)
            throw FailedPreconditionError(
                "FailedPreconditionError: "
                "UdpChannel isn't bound yet.");
        return {Endpoint::Protocol::UDP, _bindAddress, getBoundPort()};
    }

    /**
     * @brief UDPによるメッセージ受信を開始する
     *
     * ※既にバインド済みの場合はassertion failureとなります。
     *
     * @param port
     * バインドするポート番号。0を指定するとOSが空いているポートを割り当てます。
     * @return 受信開始に成功した場合はtrue、失敗した場合はfalse
     */
    bool startReceiving(int port)
    {
        // すでにbind済みの場合はエラーとしてassert
        assert(!_isBound && "UdpChannel is already bound.");

        // 利用可能なIPアドレスからバインド用アドレスを決定する
        juce::String chosenAddress = chooseBindAddress();
        if(chosenAddress.isEmpty()) return false;

        // ポートをバインドする
        if(_socket.bindToPort(port))
        {
            // ポート番号が0でない場合は、指定したポートでバインドされていることを保証する
            assert(port == 0 || _socket.getBoundPort() == port);

            // バインドに成功したアドレスと状態を保存
            _bindAddress = chosenAddress;
            _isBound = true;

            _thread.startThread();
            return true;
        }
        else
        {
            return false;
        }
    }

    /**
     * @brief UDPによる受信処理を終了する
     */
    void stopReceiving()
    {
        if(!_isStopped)  // 二重停止を防ぐ
        {
            _isStopped = true;
            _thread.signalThreadShouldExit();
            _thread.stopThread(1000);  // スレッド停止
            _socket.shutdown();        // 安全にソケットを閉じる
        }
    }

    /**
     * @brief 指定のリモートホストへメッセージを送信する
     * @param remoteHostname リモートホスト名
     * @param remotePortNumber リモートホストのポート番号
     * @param sessionId セッションID
     * @param bodyType メッセージ種別
     * @param bodyData メッセージ本文データへのポインタ
     * @param bodySize メッセージ本文サイズ
     */
    void sendMessage(const juce::String& remoteHostname, int remotePortNumber,
                     uint32_t sessionId, uint32_t bodyType,
                     const void* bodyData, size_t bodySize) override
    {
        if(_socket.getBoundPort() == -1)
        {
            DBG("Socket is not bound.");
            assert(false);
            return;
        }
        auto buf = nam::createMessageBuffer(sessionId, bodyType, bodySize,
                                            bodyData, 0, nullptr);
        // Maximum Transmission Unit
        const int UDP_MTU = 1472;
        // メッセージサイズがMTUを超える場合、分割送信が必要です
        assert(buf.size() < UDP_MTU);
        _socket.write(remoteHostname, remotePortNumber, buf.data(),
                      (int)buf.size());
    }

   private:
    /**
     * @brief 内部のデータ読み取り処理（受信スレッドで実行）
     */
    void read()
    {
        while(!_thread.threadShouldExit())
        {
            std::array<uint8_t, 1024> buffer;
            juce::String senderIP;
            int senderPort = 0;

            // 読み取り可能になるまで待つ。タイムアウトは100ms。
            if(_socket.waitUntilReady(true, 100) > 0)
            {
                int bytesRead = _socket.read(buffer.data(), (int)buffer.size(),
                                             false, senderIP, senderPort);
                if(bytesRead > 0)
                {
                    // 最低限メッセージディスクリプタのサイズを満たしているか確認
                    if(bytesRead < (int)nam::MessageDescriptor::SIZE) continue;

                    // メッセージディスクリプタを抽出
                    std::array<uint8_t, nam::MessageDescriptor::SIZE> descBuf;
                    std::memcpy(descBuf.data(), buffer.data(),
                                nam::MessageDescriptor::SIZE);
                    nam::MessageDescriptor descriptor(descBuf);

                    assert(descriptor.getVersion() == 0);

                    auto contextSize = descriptor.getContextSize();
                    auto bodySize = descriptor.getBodySize();
                    auto totalSize =
                        nam::MessageDescriptor::SIZE + contextSize + bodySize;
                    if(bytesRead < (int)totalSize) continue;

                    // コンテキストと本文データを切り出す
                    const uint8_t* contextPtr =
                        buffer.data() + nam::MessageDescriptor::SIZE;
                    const uint8_t* bodyPtr = contextPtr + contextSize;

                    auto sessionId = descriptor.getSessionId();
                    auto bodyType = descriptor.getBodyType();

                    // 小さいバッファのため、受信ごとにコピーしてデータ競合を防ぐ
                    std::vector<uint8_t> contextBuffer(
                        contextPtr, contextPtr + contextSize);
                    std::vector<uint8_t> bodyBuffer(bodyPtr,
                                                    bodyPtr + bodySize);

                    // _handler をメインスレッド上で実行
                    auto handlerPtr =
                        &_handler;  // _handler へのポインタをキャプチャ
                    juce::MessageManager::callAsync([sessionId, bodyType,
                                                     contextBuffer, bodyBuffer,
                                                     handlerPtr]() {
                        handlerPtr->handleRtCommand(
                            sessionId, bodyType, bodyBuffer.size(),
                            bodyBuffer.data(), contextBuffer.size(),
                            contextBuffer.data());
                    });
                }
            }
        }
    }

    /**
     * @brief バインドするIPアドレスを選択する
     *
     * 利用可能な全IPアドレスを評価し、以下の優先順位に基づいて選択します:
     *   1. プライベートアドレス (10.x.x.x, 172.16.x.x～172.31.x.x, 192.168.x.x)
     *   2. リンクローカルアドレス (169.254.x.x)
     *   3. その他の有効なアドレス
     *
     * 無効なアドレスとして、ループバック、ブロードキャスト、マルチキャスト、
     * 予約済みアドレス（0.0.0.0）を除外します。
     *
     * @return
     * 選択したバインド用IPアドレス。選択できなかった場合は空文字列を返します。
     */
    juce::String chooseBindAddress()
    {
        auto addresses = juce::IPAddress::getAllAddresses();
        juce::String chosenAddress;
        // 第一優先：プライベートアドレス
        for(auto const& addr : addresses)
        {
            auto ip = addr.toString();
            if(!isValidBindAddress(ip)) continue;
            if(isPrivateAddress(ip))
            {
                chosenAddress = ip;
                break;
            }
        }
        // 第二優先：リンクローカルアドレス
        if(chosenAddress.isEmpty())
        {
            for(auto const& addr : addresses)
            {
                auto ip = addr.toString();
                if(!isValidBindAddress(ip)) continue;
                if(isLinkLocalAddress(ip))
                {
                    chosenAddress = ip;
                    break;
                }
            }
        }
        // 第三優先：その他の通常の有効なアドレス
        if(chosenAddress.isEmpty())
        {
            for(auto const& addr : addresses)
            {
                auto ip = addr.toString();
                if(!isValidBindAddress(ip)) continue;
                chosenAddress = ip;
                break;
            }
        }
        return chosenAddress;
    }

    /**
     * @brief 指定IPアドレスがプライベートアドレスかどうか判定する
     *
     * プライベートアドレスは以下になります:
     *  - 10.0.0.0 ～ 10.255.255.255
     *  - 172.16.0.0 ～ 172.31.255.255
     *  - 192.168.0.0 ～ 192.168.255.255
     *
     * @param ip IPアドレス（文字列形式）
     * @return プライベートアドレスなら true、それ以外は false
     */
    static bool isPrivateAddress(const juce::String& ip)
    {
        if(ip.startsWith("10.")) return true;
        if(ip.startsWith("192.168.")) return true;
        if(ip.startsWith("172."))
        {
            auto tokens = juce::StringArray::fromTokens(ip, ".", "");
            if(tokens.size() >= 2)
            {
                int secondOctet = tokens[1].getIntValue();
                if(secondOctet >= 16 && secondOctet <= 31) return true;
            }
        }
        return false;
    }

    /**
     * @brief 指定IPアドレスがリンクローカルアドレスかどうか判定する
     *
     * リンクローカルアドレスは 169.254.0.0 ～ 169.254.255.255 です。
     *
     * @param ip IPアドレス（文字列形式）
     * @return リンクローカルアドレスなら true、それ以外は false
     */
    static bool isLinkLocalAddress(const juce::String& ip)
    {
        return ip.startsWith("169.254.");  // リンクローカルアドレスの判定
    }

    /**
     * @brief 指定IPアドレスがバインド可能な有効アドレスか判定する
     *
     * 次のアドレスはバインドできないものとします:
     *   - 予約済みアドレス: "0.0.0.0"
     *   - ループバックアドレス: 127.x.x.x
     *   - ブロードキャストアドレス: "255.255.255.255"
     *   - マルチキャストアドレス: 224.0.0.0 ～ 239.255.255.255
     *
     * @param ip IPアドレス（文字列形式）
     * @return 有効なら true、それ以外は false
     */
    static bool isValidBindAddress(const juce::String& ip)
    {
        if(ip == "0.0.0.0") return false;          // 予約済みアドレスは除外
        if(ip.startsWith("127.")) return false;    // ループバックは除外
        if(ip == "255.255.255.255") return false;  // ブロードキャストは除外

        auto tokens = juce::StringArray::fromTokens(ip, ".", "");
        if(tokens.size() > 0)
        {
            int firstOctet = tokens[0].getIntValue();
            if(firstOctet >= 224 && firstOctet <= 239)
                return false;  // マルチキャストアドレスは除外
        }
        return true;
    }

    juce::DatagramSocket _socket;   ///< UDPソケット
    bool _isStopped;                ///< 受信停止済みかを記録
    bool _isBound;                  ///< bind済みかを記録
    juce::String _bindAddress;      ///< バインドしたIPアドレス
    CallbackThread _thread;         ///< 内部受信スレッド管理
    ProtoMessageHandler& _handler;  ///< メッセージハンドラ
};

}  // namespace novonotes
