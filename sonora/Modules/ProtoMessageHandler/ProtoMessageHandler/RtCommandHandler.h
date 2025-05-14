#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <ProtoMessageHandler/Endpoint.h>
#include <novonotes/audio_engine/v1alpha1/rt_session.pb.h>

#include "ParameterSyncKey.h"
#include "Utils/ProtoToJson.h"

namespace pb
{
using namespace novonotes::audio_engine::v1alpha1;
}
namespace novonotes
{
class RtCommandHandler
{
   public:
    RtCommandHandler(AudioEngine& engine) : _engine(engine) {}

    void handleRtCommand(uint16_t sessionId, uint16_t bodyType, size_t bodySize,
                         uint8_t const* bodyData, size_t contextSize,
                         uint8_t const* contextData)
    {
        pb::RtCommandBatch commandBatch;
        bool result =
            commandBatch.ParseFromArray(bodyData, static_cast<int>(bodySize));
        assert(result);

        DBG(protoToJsonString(commandBatch));

        // コマンドバッチの各コマンドを処理
        for(int i = 0; i < commandBatch.commands_size(); i++)
        {
            const auto& command = commandBatch.commands(i);

            if(command.has_update_parameter())
            {
                // UpdateParameterコマンドの処理
                processUpdateParameterCommand(command.update_parameter());
            }
            else if(command.has_finalize_parameter())
            {
                // FinalizeParameterコマンドの処理
                processFinalizeParameterCommand(command.finalize_parameter());
            }
            // 将来的に他のコマンドタイプが追加される場合はここに追加
        }
    }

   private:
    AudioEngine& _engine;

    void processUpdateParameterCommand(
        const pb::RtUpdateParameterCommand& command)
    {
        const auto& parameterSyncKeyString = command.parameter_sync_key();

        auto paramSyncKey = ParameterSyncKey::parse(parameterSyncKeyString);
        auto deviceId = paramSyncKey.deviceInstanceId;
        auto paramId = paramSyncKey.parameterId;

        // パラメータの状態を確認
        bool isChanging =
            _engine.getStudioService().isParameterChanging(deviceId, paramId);

        // 値を取得
        float value = 0.0;
        if(command.new_value_case() ==
           pb::RtUpdateParameterCommand::kNormalizedValue)
        {
            value = (float)command.normalized_value();
        }
        else if(command.new_value_case() ==
                pb::RtUpdateParameterCommand::kTextValue)
        {
            // テキスト値を数値に変換
            value = _engine.getStudioService().stringToParameterValue(
                deviceId, paramId, command.text_value());
        }
        else
        {
            Logger::info("No value provided in RtUpdateParameterCommand");
            return;
        }

        // 最初のUpdateコマンドの場合はbeginParameterChangeを呼ぶ
        if(!isChanging)
        {
            _engine.getStudioService().beginParameterChange(deviceId, paramId);
        }

        // パラメータ値を設定
        _engine.getStudioService().setParameterBaseValue(deviceId, paramId,
                                                         value);
    }

    void processFinalizeParameterCommand(
        const pb::RtFinalizeParameterCommand& command)
    {
        const auto& parameterSyncKeyString = command.parameter_sync_key();

        auto paramSyncKey = ParameterSyncKey::parse(parameterSyncKeyString);
        auto deviceId = paramSyncKey.deviceInstanceId;
        auto paramId = paramSyncKey.parameterId;

        // 値を取得（指定されている場合）
        if(command.new_value_case() ==
           pb::RtFinalizeParameterCommand::kNormalizedValue)
        {
            double value = command.normalized_value();
            _engine.getStudioService().setParameterBaseValue(deviceId, paramId,
                                                             (float)value);
        }
        else if(command.new_value_case() ==
                pb::RtFinalizeParameterCommand::kTextValue)
        {
            // テキスト値を数値に変換して設定
            double value = _engine.getStudioService().stringToParameterValue(
                deviceId, paramId, command.text_value());
            _engine.getStudioService().setParameterBaseValue(deviceId, paramId,
                                                             (float)value);
        }

        // パラメータ変更を終了
        _engine.getStudioService().endParameterChange(deviceId, paramId);
    }
};

}  // namespace novonotes
