#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Utils/CallbackTimer.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <juce_core/juce_core.h>
#include <novonotes/audio_engine/v1alpha1/rt_session.pb.h>
#include <novonotes/audio_engine/v1alpha1/transport.pb.h>

#include <algorithm>
#include <memory>
#include <vector>

#include "Delegates.h"
#include "ParameterSyncKey.h"
#include "RtSessionManager.h"

namespace pb
{
using namespace novonotes::audio_engine::v1alpha1;
using namespace google::protobuf;
}  // namespace pb

namespace novonotes
{

/// 複数の State Receiver に対して RtStateFragment のメッセージを毎秒 30
/// 回送る。
class RtStateBroadcaster
{
   public:
    RtStateBroadcaster(AudioEngine& e, RtSessionManager& s)
        : _engine(e)
        , _timer()
        , _dispatcher(nullptr)
        , _sessionManager(s)
        , _sequenceNumber(1)

    {
        _timer.callback = [this](auto&) { broadcast(); };
    }

    void setDelegates(RtDispatchDelegate* rdd)
    {
        assert(rdd != nullptr);
        _dispatcher = rdd;
    }

    void start()
    {
        // Call `setDelegates` before calling `start`.
        assert(_dispatcher != nullptr);
        _timer.startTimerHz(30);
    }

   private:
    void broadcast()
    {
        auto sessions = _sessionManager.getSessions();
        if(sessions.empty())
        {
            return;
        }

        for(const auto& ses : sessions)
        {
            pb::RtStateFragment state;

            if(ses.playheadPositionStreamEnabled)
            {
                auto pos = _engine.getTransportService().getPlayheadPosition();

                pb::RtPlayheadPosition pbPos;
                // TODO: sequenceNumber はセッションごとに独立して管理。
                pbPos.set_sequence_number(_sequenceNumber++);
                pbPos.set_position_ppq(pos.ppqPosition);
                pbPos.set_position_seconds(pos.timeInSeconds);
                pbPos.set_position_samples(pos.timeInSamples);

                auto* entity = state.add_entity_subset();
                entity->mutable_playhead()->CopyFrom(pbPos);
            }

            // パラメータの状態をStudioServiceから取得
            for(const auto& parameterSyncKeyString :
                ses.activeParameterSyncKeys)
            {
                pb::RtParameter pbParam;

                pbParam.set_parameter_sync_key(parameterSyncKeyString);
                // TODO: sequenceNumber
                // はセッションごと、パラメーターごとに独立して管理。
                pbParam.set_sequence_number(_sequenceNumber++);

                // パラメータの値を設定
                try
                {
                    auto paramSyncKey =
                        ParameterSyncKey::parse(parameterSyncKeyString);
                    auto deviceId = paramSyncKey.deviceInstanceId;
                    auto paramId = paramSyncKey.parameterId;

                    // StudioServiceからパラメータの状態を取得
                    auto pbParamState = getParameterState(deviceId, paramId);
                    pbParam.set_state(pbParamState);

                    // 正規化された値を取得
                    float modValue =
                        _engine.getStudioService().getParameterModulatedValue(
                            deviceId, paramId);
                    pbParam.set_normalized_unmodulated_value(modValue);

                    // テキスト値を取得
                    juce::String juceTextValue =
                        _engine.getStudioService().parameterValueToString(
                            deviceId, paramId, modValue);
                    pbParam.set_text_unmodulated_value(
                        juceTextValue.toStdString());
                }
                catch(const Error& e)
                {
                    // エラーが発生した場合はログに書き込んで次のパラメータへ
                    Logger::info("Failed to broadcast parameter." +
                                 e.description);
                    continue;
                }
                auto* entity = state.add_entity_subset();
                entity->mutable_parameter()->CopyFrom(pbParam);
            }

            if(state.entity_subset_size() == 0)
            {
                continue;
            }

            _dispatcher->sendMessage(
                ses.endpoint.address, ses.endpoint.port, ses.id,
                0,  // TODO: bodyType
                state.SerializeAsString().data(), (size_t)state.ByteSizeLong());
        }
    }

    novonotes::audio_engine::v1alpha1::RtParameter_State getParameterState(
        const DeviceInstanceId& deviceId, const ParameterId& paramId) const
    {
        // StudioServiceからパラメータの状態を取得
        bool isChanging =
            _engine.getStudioService().isParameterChanging(deviceId, paramId);

        // isParameterChanging == true → UPDATING
        // isParameterChanging == false → FINALIZED
        return isChanging ? novonotes::audio_engine::v1alpha1::
                                RtParameter_State_STATE_UPDATING
                          : novonotes::audio_engine::v1alpha1::
                                RtParameter_State_STATE_FINALIZED;
    }

    AudioEngine& _engine;
    CallbackTimer _timer;
    RtDispatchDelegate* _dispatcher;
    RtSessionManager& _sessionManager;
    uint32_t _sequenceNumber = 1;
};
}  // namespace novonotes
