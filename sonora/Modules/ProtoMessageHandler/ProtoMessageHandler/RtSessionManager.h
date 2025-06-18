#pragma once

#include <AudioEngineCore/Common/Errors.h>

#include <regex>
#include <string>
#include <unordered_map>

#include "Endpoint.h"
#include "novonotes/audio_engine/v1alpha1/device_instance.pb.h"

namespace novonotes
{

struct RtSession
{
    uint32_t id;
    Endpoint endpoint;
    bool playheadPositionStreamEnabled = false;
    // 同期中の parameterSyncKey のリスト
    std::vector<std::string> activeParameterSyncKeys;

    RtSession(uint32_t id_, const Endpoint& endpoint_)
        : id(id_)
        , endpoint(endpoint_)
        , playheadPositionStreamEnabled(false)
        , activeParameterSyncKeys()
    {}
};

class RtSessionManager
{
   public:
    /// セッションを開始する。
    ///
    /// session id 重複の場合、失敗し AlreadyExistsError を投げる。
    void startSession(uint32_t sessionId, const Endpoint& endpoint)
    {
        if(endpoint.protocol != Endpoint::Protocol::UDP)
        {
            throw UnimplementedError("The protocol is not supported.");
        }
        if(std::none_of(
               _sessions.begin(), _sessions.end(),
               [&sessionId](const auto& s) { return s.id == sessionId; }))
        {
            _sessions.push_back({sessionId, endpoint});
        }
        else
        {
            throw AlreadyExistsError("Session already exists: " +
                                     std::to_string(sessionId));
        }
    }

    void stopSession(uint32_t sessionId)
    {
        _sessions.erase(std::remove_if(_sessions.begin(), _sessions.end(),
                                       [&sessionId](const auto& s) {
                                           return s.id == sessionId;
                                       }),
                        _sessions.end());
    }

    void enablePlayheadPositionStream(uint32_t sessionId)
    {
        auto it = std::find_if(
            _sessions.begin(), _sessions.end(),
            [&sessionId](const RtSession& s) { return s.id == sessionId; });
        if(it != _sessions.end())
        {
            it->playheadPositionStreamEnabled = true;
        }
        else
        {
            throw NotFoundError("Session not found: " +
                                std::to_string(sessionId));
        }
    }

    void disablePlayheadPositionStream(uint32_t sessionId)
    {
        auto it = std::find_if(
            _sessions.begin(), _sessions.end(),
            [&sessionId](const RtSession& s) { return s.id == sessionId; });
        if(it != _sessions.end())
        {
            it->playheadPositionStreamEnabled = false;
        }
        else
        {
            throw NotFoundError("Session not found: " +
                                std::to_string(sessionId));
        }
    }

    void startParameterSync(uint32_t sessionId,
                            const std::vector<std::string>& parameterIds)
    {
        auto it = std::find_if(
            _sessions.begin(), _sessions.end(),
            [&sessionId](const RtSession& s) { return s.id == sessionId; });
        if(it != _sessions.end())
        {
            // 同期中のパラメータIDリストに追加
            for(const auto& parameterId : parameterIds)
            {
                // 既に同期中のパラメータでなければリストに追加
                if(std::find(it->activeParameterSyncKeys.begin(),
                             it->activeParameterSyncKeys.end(),
                             parameterId) == it->activeParameterSyncKeys.end())
                {
                    it->activeParameterSyncKeys.push_back(parameterId);
                }
            }
        }
        else
        {
            throw NotFoundError("Session not found: " +
                                std::to_string(sessionId));
        }
    }

    void stopParameterSync(uint32_t sessionId,
                           const std::vector<std::string>& parameterIds)
    {
        auto it = std::find_if(
            _sessions.begin(), _sessions.end(),
            [&sessionId](const RtSession& s) { return s.id == sessionId; });
        if(it != _sessions.end())
        {
            // 同期中のパラメータIDリストから削除
            for(const auto& parameterId : parameterIds)
            {
                it->activeParameterSyncKeys.erase(
                    std::remove(it->activeParameterSyncKeys.begin(),
                                it->activeParameterSyncKeys.end(), parameterId),
                    it->activeParameterSyncKeys.end());
            }
        }
        else
        {
            throw NotFoundError("Session not found: " +
                                std::to_string(sessionId));
        }
    }

    std::vector<RtSession> getSessions() const { return _sessions; }

   private:
    std::vector<RtSession> _sessions;
};
}  // namespace novonotes
