#include "HandlerV1Alpha1.h"

#include <AudioEngineCore/Utils/GetProcessId.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <novonotes/audio_engine/v1alpha1/audio_region.pb.h>
#include <novonotes/audio_engine/v1alpha1/connection.pb.h>
#include <novonotes/audio_engine/v1alpha1/debug_utility.pb.h>
#include <novonotes/audio_engine/v1alpha1/device_descriptor.pb.h>
#include <novonotes/audio_engine/v1alpha1/device_instance.pb.h>
#include <novonotes/audio_engine/v1alpha1/engine_management.pb.h>
#include <novonotes/audio_engine/v1alpha1/rt_session.pb.h>
#include <novonotes/audio_engine/v1alpha1/track.pb.h>
#include <novonotes/audio_engine/v1alpha1/transport.pb.h>
#include <novonotes/audio_engine/v1alpha1/type/body_type.pb.h>
#include <novonotes/audio_engine/v1alpha1/type/engine_error.pb.h>

#include <algorithm>
#include <cassert>

#include "../ParameterSyncKey.h"
#include "../RtSessionManager.h"
#include "../RtStateBroadcaster.h"
#include "PbConverter.h"

namespace pb
{
using namespace novonotes::audio_engine::v1alpha1;
using namespace novonotes::audio_engine::v1alpha1::type;
using namespace google::protobuf;
}  // namespace pb

namespace novonotes
{

static ConnectionSrc getConnectionSrc(const pb::Connection& pbConnection)
{
    if(pbConnection.source_case() == pb::Connection::SOURCE_NOT_SET)
    {
        throw InvalidArgumentError("The 'source' field must be set.");
    }
    if(pbConnection.has_src_audio_track_id())
    {
        return AudioTrackId{pbConnection.src_audio_track_id()};
    }
    if(pbConnection.has_src_device_id())
    {
        return DeviceInstanceId{pbConnection.src_device_id()};
    }
    throw InternalError("Unhandled 'from' field");
}

static ConnectionDest getConnectionDest(const pb::Connection& pbConnection)
{
    if(pbConnection.destination_case() == pb::Connection::DESTINATION_NOT_SET)
    {
        throw InvalidArgumentError("The 'destination' field must be set.");
    }
    if(pbConnection.has_dest_audio_output())
    {
        return AudioOutputTag{};
    }
    if(pbConnection.has_dest_device_id())
    {
        return DeviceInstanceId{pbConnection.dest_device_id()};
    }
    throw InternalError("Unhandled 'destination' field");
}

static void writeErrorToLog(const Error& e)
{
    juce::String message;
    message << "Reqeust failed: " << e.description;
    novonotes::Logger::info(message);
}

void HandlerV1Alpha1::handleMessage(uint16_t bodyType, size_t contentSize,
                                    uint8_t const* contentData,
                                    size_t contextSize,
                                    uint8_t const* contextData)
{
    juce::Logger::writeToLog("Message received.");
    pb::Struct context;
    try
    {
        context = deserializePbMessage<pb::Struct>(contextData, contextSize);
        handleMessageImpl(bodyType, contentSize, contentData, context);
    }
    catch(const Error& e)
    {
        writeErrorToLog(e);
        sendErrorMessage(e, context);
        return;
    }
}

static void handleSetParameterValueRequest(
    const pb::SetParameterValueRequest& request,
    pb::SetParameterValueResponse* response, StudioService& studio,
    DeviceInstancePbConverter& converter)
{
    DeviceInstanceId deviceId{request.device_instance_id()};
    ParameterId parameterId{request.parameter_id()};
    auto stringValue = request.text_value();
    auto floatValue =
        studio.stringToParameterValue(deviceId, parameterId, stringValue);

    // パラメータが変更中かどうかを確認
    bool isChanging = studio.isParameterChanging(deviceId, parameterId);

    // 最初のUpdateの場合のみbeginParameterChangeを呼び出す
    if(!isChanging)
    {
        // パラメータ変更を開始
        studio.beginParameterChange(deviceId, parameterId);
    }

    // パラメータ値を設定
    studio.setParameterBaseValue(deviceId, parameterId, floatValue);
    auto instance = studio.getDeviceInstance(deviceId);
    *response->mutable_device_instance() =
        converter.convertToPbMessage(instance);
}

void HandlerV1Alpha1::handleMessageImpl(uint16_t bodyType, size_t contentSize,
                                        uint8_t const* data,
                                        const pb::Struct& context)
{
    if(bodyType == pb::BodyType::BODY_TYPE_RT_UPDATE_PARAMETER_COMMAND)
    {
        auto command = deserializePbMessage<pb::RtUpdateParameterCommand>(
            data, contentSize);

        auto paramSyncKey =
            ParameterSyncKey::parse(command.parameter_sync_key());

        auto deviceId = paramSyncKey.deviceInstanceId;
        auto paramId = paramSyncKey.parameterId;

        // パラメータの状態を確認
        bool isChanging =
            _engine.getStudioService().isParameterChanging(deviceId, paramId);

        // 値を取得
        double value = 0.0;
        if(command.new_value_case() ==
           pb::RtUpdateParameterCommand::kNormalizedValue)
        {
            value = command.normalized_value();
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
            throw InvalidArgumentError(
                "No value provided in RtUpdateParameterCommand");
        }

        // 最初のUpdateコマンドの場合はbeginParameterChangeを呼ぶ
        if(!isChanging)
        {
            _engine.getStudioService().beginParameterChange(deviceId, paramId);
        }

        // パラメータ値を設定
        _engine.getStudioService().setParameterBaseValue(deviceId, paramId,
                                                         (float)value);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_RT_FINALIZE_PARAMETER_COMMAND)
    {
        auto command = deserializePbMessage<pb::RtFinalizeParameterCommand>(
            data, contentSize);

        auto paramSyncKey =
            ParameterSyncKey::parse(command.parameter_sync_key());

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
    else if(bodyType == pb::BodyType::BODY_TYPE_INITIALIZE_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::InitializeRequest>(data, contentSize);
        auto appInstanceId = request.app_instance_id();
        auto* logger = juce::Logger::getCurrentLogger();
        if(auto* l = dynamic_cast<novonotes::Logger*>(logger))
        {
            l->writeHeader(appInstanceId);
        }

        pb::InitializeResponse response;
        std::string engineTypeId = _engine.getEngineTypeId();
        std::string displayName = _engine.getDisplayName();

        response.set_pid(getProcessId());
        response.set_engine_type_id(engineTypeId);
        response.set_display_name(displayName);
        response.set_schema_version("v1alpha1");

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_INITIALIZE_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_CREATE_AUDIO_REGION_REQUEST)
    {
        auto request = deserializePbMessage<pb::CreateAudioRegionRequest>(
            data, contentSize);
        auto const& region = request.audio_region();

        // Request Validation
        {
            if(request.parent_id() == "")
            {
                throw InvalidArgumentError("Parent ID must be specified.");
            }
            if(region.id() == "")
            {
                throw InvalidArgumentError(
                    "Audio Region ID must be specified.");
            }
            if(region.source_file_path() == "")
            {
                throw InvalidArgumentError(
                    "Source file path must be specified.");
            }
        }

        std::optional<BeatDuration> duration =
            region.has_duration()
                ? std::optional<BeatDuration>{{region.duration()}}
                : std::nullopt;

        AudioRegionId appSpecifiedId{request.audio_region().id()};

        auto newRegionId = _engine.getArrangementService().addAudioRegion(
            {request.parent_id()}, {region.source_file_path()},
            {region.position()}, duration, appSpecifiedId, false,

            static_cast<float>(region.gain_db()));

        pb::CreateAudioRegionResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_CREATE_AUDIO_REGION_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_UPDATE_AUDIO_REGION_REQUEST)
    {
        throw UnimplementedError("BODY_TYPE_UPDATE_AUDIO_REGION_REQUEST");
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_DELETE_AUDIO_REGION_REQUEST)
    {
        auto request = deserializePbMessage<pb::DeleteAudioRegionRequest>(
            data, contentSize);
        const auto& idStr = request.audio_region_id();
        if(idStr.empty())
        {
            throw InvalidArgumentError("Audio Region ID must be specified");
        }
        AudioRegionId regionId{idStr};
        _engine.getArrangementService().removeAudioRegion(regionId);
        pb::DeleteAudioRegionResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_DELETE_AUDIO_REGION_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_CREATE_TRACK_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::CreateTrackRequest>(data, contentSize);

        const auto& idStr = request.track().id();
        if(idStr.empty())
        {
            throw InvalidArgumentError("AudioTrack ID must be specified");
        }
        if(request.track().type() == pb::Track_TrackType_TRACK_TYPE_UNSPECIFIED)
        {
            throw InvalidArgumentError(
                "`type` field of Track must be specified.");
        }
        if(request.track().type() != pb::Track_TrackType_TRACK_TYPE_AUDIO)
        {
            throw UnimplementedError(
                "The specified track type is not implemented yet.");
        }
        AudioTrackId userProvidedId{idStr};

        _engine.getArrangementService().createAudioTrack(userProvidedId);

        pb::CreateTrackResponse response;  // 空のレスポンスを使用
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_CREATE_TRACK_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_UPDATE_TRACK_REQUEST)
    {
        throw UnimplementedError("BODY_TYPE_DELETE_AUDIO_TRACK_REQUEST");
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_DELETE_TRACK_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::DeleteTrackRequest>(data, contentSize);

        auto id = request.track_id();

        _engine.getArrangementService().deleteTrack({id});

        pb::DeleteTrackResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_DELETE_TRACK_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_CONNECT_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::ConnectRequest>(data, contentSize);

        auto const& connectionMsg = request.connection();
        auto src = getConnectionSrc(connectionMsg);
        auto dest = getConnectionDest(connectionMsg);

        _engine.getStudioService().connect(src, dest);

        pb::ConnectResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_CONNECT_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_DISCONNECT_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::DisconnectRequest>(data, contentSize);

        auto const& connectionMsg = request.connection();
        auto src = getConnectionSrc(connectionMsg);
        auto dest = getConnectionDest(connectionMsg);

        _engine.getStudioService().connect(src, dest);

        pb::DisconnectResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_DISCONNECT_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_DEBUG_STATE_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::DebugStateRequest>(data, contentSize);

        auto stateString = _engine.getDebugUtilityService().getDebugState();

        pb::DebugStateResponse response;
        response.set_state(stateString);

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_DEBUG_STATE_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_SAVE_STATE_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::SaveStateRequest>(data, contentSize);

        auto dest = juce::File(request.dest_file_path());
        _engine.getDebugUtilityService().saveState(dest);

        pb::SaveStateResponse response;

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_SAVE_STATE_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_CREATE_DEVICE_INSTANCE_REQUEST)
    {
        auto request = deserializePbMessage<pb::CreateDeviceInstanceRequest>(
            data, contentSize);

        const auto& idStr = request.device_instance().id();
        if(idStr.empty())
        {
            throw InvalidArgumentError("Device Instance ID must be specified");
        }
        DeviceInstanceId appSpecifiedId{idStr};

        const auto& typeIdStr = request.device_instance().device_type_id();
        if(typeIdStr.empty())
        {
            throw InvalidArgumentError("Device Type ID must be specified");
        }
        DeviceTypeId deviceTypeId{typeIdStr};

        // DeviceInstance を作成
        _engine.getStudioService().createDeviceInstance(deviceTypeId,
                                                        appSpecifiedId);

        // Response の送信
        {
            pb::CreateDeviceInstanceResponse response;

            auto instance =
                _engine.getStudioService().getDeviceInstance(appSpecifiedId);

            *response.mutable_device_instance() =
                _deviceInstancePbConverter.convertToPbMessage(instance);

            _dispatcher->sendMessage(
                response,
                pb::BodyType::BODY_TYPE_CREATE_DEVICE_INSTANCE_RESPONSE,
                context);
        }
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_DELETE_DEVICE_INSTANCE_REQUEST)
    {
        auto request = deserializePbMessage<pb::DeleteDeviceInstanceRequest>(
            data, contentSize);

        DeviceInstanceId instanceId{request.device_instance_id()};
        if(instanceId.value == "")
        {
            throw InvalidArgumentError("Device instance id must be specified.");
        }
        _engine.getStudioService().deleteDeviceInstance(instanceId);

        pb::DeleteDeviceInstanceResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_DELETE_DEVICE_INSTANCE_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_START_PLAYBACK_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StartPlaybackRequest>(data, contentSize);

        _engine.getTransportService().startPlay();

        pb::StartPlaybackResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_START_PLAYBACK_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_STOP_PLAYBACK_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StopPlaybackRequest>(data, contentSize);

        _engine.getTransportService().stopPlay();

        pb::StopPlaybackResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_STOP_PLAYBACK_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_UPDATE_TRANSPORT_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::UpdateTransportRequest>(data, contentSize);
        auto transport_patch = request.transport();
        auto update_mask = request.update_mask().paths();
        if(update_mask.empty())
        {
            throw InvalidArgumentError("update_mask is required.");
        }
        for(auto path : update_mask)
        {
            if(path == "tempo")
            {
                _engine.getTransportService().setTempo(transport_patch.tempo());
            }
            if(path == "playhead_position")
            {
                _engine.getTransportService().setPlayheadPosition(
                    {transport_patch.playhead_position()});
            }
            if(path == "loop_start")
            {
                auto duration = _engine.getTransportService().getLoopDuration();
                _engine.getTransportService().setLoopRange(
                    {transport_patch.loop_start()}, duration);
            }
            if(path == "loop_duration")
            {
                auto start = _engine.getTransportService().getLoopStart();
                _engine.getTransportService().setLoopRange(
                    start, {transport_patch.loop_duration()});
            }
        }

        pb::UpdateTransportResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_UPDATE_TRANSPORT_RESPONSE,
            context);
    }
    else if(bodyType ==
            pb::BodyType::BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StartPlayheadPositionStreamRequest>(
                data, contentSize);
        auto sessionId = request.rt_session_id();
        _sessionManager.enablePlayheadPositionStream(sessionId);

        pb::StartPlayheadPositionStreamResponse response;
        _dispatcher->sendMessage(
            response,
            pb::BodyType::BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_RESPONSE,
            context);
    }
    else if(bodyType ==
            pb::BodyType::BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StopPlayheadPositionStreamRequest>(
                data, contentSize);
        auto sessionId = request.rt_session_id();
        _sessionManager.disablePlayheadPositionStream(sessionId);

        pb::StopPlayheadPositionStreamResponse response;
        _dispatcher->sendMessage(
            response,
            pb::BodyType::BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_SHUTDOWN_REQUEST)
    {
        pb::ShutdownResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_SHUTDOWN_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_PLAY_TEST_TONE_REQUEST)
    {
        pb::PlayTestToneResponse response;
        _engine.getDebugUtilityService().testTone();
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_PLAY_TEST_TONE_RESPONSE, context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_START_RT_SESSION_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StartRtSessionRequest>(data, contentSize);
        auto url = request.state_receiver_uri();
        auto endpoint = Endpoint::parse(url);
        auto sessionId = request.rt_session_id();
        if(sessionId == 0)
        {
            throw InvalidArgumentError("Invalid session id: " +
                                       std::to_string(sessionId));
        }
        _sessionManager.startSession(static_cast<uint32_t>(sessionId),
                                     endpoint);

        pb::StartRtSessionResponse response;
        auto commandReceiverEndpoint =

            _commandEndpointProvider->getCommandReceiverEndpoint();
        auto commandReceiverUri =
            commandReceiverEndpoint.toUrlString().toStdString();
        response.set_command_receiver_uri(commandReceiverUri);
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_START_RT_SESSION_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_STOP_RT_SESSION_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::StopRtSessionRequest>(data, contentSize);
        auto sessionId = request.rt_session_id();
        if(sessionId == 0)
        {
            throw InvalidArgumentError("Invalid session id: " +
                                       std::to_string(sessionId));
        }
        _sessionManager.stopSession(sessionId);

        pb::StopRtSessionResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_STOP_RT_SESSION_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_LIST_DEVICE_DESCRIPTORS_REQUEST)
    {
        auto request = deserializePbMessage<pb::ListDeviceDescriptorsRequest>(
            data, contentSize);

        // エンジンからデバイスディスクリプタのリストを取得
        auto descriptors = _engine.getStudioService().listDeviceDescriptors();

        pb::ListDeviceDescriptorsResponse response;
        for(const auto& desc : descriptors)
        {
            auto* pbDesc = response.add_device_descriptors();
            pbDesc->set_device_type_id(desc.deviceTypeId.value);
            pbDesc->set_display_name(desc.displayName);
            pbDesc->set_plugin_format_name(desc.pluginFormatName);
            // TODO: 文字列のとりうる値をよく調べてなるべく enum
            // で返せるように設計したい。 for(const auto& cat : desc.categories)
            // {
            //   pbDesc->add_category(cat);
            // }
            pbDesc->set_manufacturer_name(desc.manufacturerName);
            pbDesc->set_version(desc.version);
        }

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_LIST_DEVICE_DESCRIPTORS_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_GET_DEVICE_INSTANCE_REQUEST)
    {
        auto request = deserializePbMessage<pb::GetDeviceInstanceRequest>(
            data, contentSize);

        const auto& idStr = request.device_instance_id();
        if(idStr.empty())
        {
            throw InvalidArgumentError("Device Instance ID must be specified");
        }
        DeviceInstanceId instanceId{idStr};

        // DeviceInstance を取得
        auto instance =
            _engine.getStudioService().getDeviceInstance(instanceId);

        // Response の送信
        {
            pb::GetDeviceInstanceResponse response;

            *response.mutable_device_instance() =
                _deviceInstancePbConverter.convertToPbMessage(instance);

            _dispatcher->sendMessage(
                response, pb::BodyType::BODY_TYPE_GET_DEVICE_INSTANCE_RESPONSE,
                context);
        }
    }
    else if(bodyType ==
            pb::BodyType::BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::RestoreDeviceInstanceStateRequest>(
                data, contentSize);

        DeviceInstanceId instanceId{request.device_instance_id()};
        if(instanceId.value.empty())
        {
            throw InvalidArgumentError("Device Instance ID must be specified");
        }

        std::string serializedState = request.state_restoration_token();
        if(serializedState.empty())
        {
            throw InvalidArgumentError(
                "State Restoration Token must be specified");
        }

        // Restore
        _engine.getStudioService().restoreDeviceInstanceState(instanceId,
                                                              serializedState);

        // DeviceInstance を取得
        auto instance =
            _engine.getStudioService().getDeviceInstance(instanceId);

        // Response の送信
        {
            pb::RestoreDeviceInstanceStateResponse response;

            *response.mutable_device_instance() =
                _deviceInstancePbConverter.convertToPbMessage(instance);

            _dispatcher->sendMessage(
                response,
                pb::BodyType::BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_RESPONSE,
                context);
        }
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_SET_PARAMETER_VALUE_REQUEST)
    {
        auto request = deserializePbMessage<pb::SetParameterValueRequest>(
            data, contentSize);

        pb::SetParameterValueResponse response;

        handleSetParameterValueRequest(request, &response,
                                       _engine.getStudioService(),
                                       _deviceInstancePbConverter);

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_SET_PARAMETER_VALUE_RESPONSE,
            context);
    }
    else if(bodyType ==
            pb::BodyType::BODY_TYPE_BATCH_SET_PARAMETER_VALUES_REQUEST)
    {
        auto batchRequest =
            deserializePbMessage<pb::BatchSetParameterValuesRequest>(
                data, contentSize);
        pb::BatchSetParameterValuesResponse batchResponse;
        for(auto request : batchRequest.requests())
        {
            auto* res = batchResponse.add_responses();
            handleSetParameterValueRequest(request, res,
                                           _engine.getStudioService(),
                                           _deviceInstancePbConverter);
        }
        _dispatcher->sendMessage(
            batchResponse,
            pb::BodyType::BODY_TYPE_BATCH_SET_PARAMETER_VALUES_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_START_PARAMETER_SYNC_REQUEST)
    {
        auto request = deserializePbMessage<pb::StartParameterSyncRequest>(
            data, contentSize);

        if(request.rt_session_id() == 0)
        {
            throw InvalidArgumentError("Invalid session id");
        }

        // RepeatedPtrField を vector に変換
        std::vector<std::string> parameterIds;
        for(const auto& id : request.parameter_sync_keys())
        {
            parameterIds.push_back(id);
        }

        // セッションの存在確認とパラメーター同期の開始
        _sessionManager.startParameterSync(request.rt_session_id(),
                                           parameterIds);

        pb::StartParameterSyncResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_START_PARAMETER_SYNC_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_STOP_PARAMETER_SYNC_REQUEST)
    {
        auto request = deserializePbMessage<pb::StopParameterSyncRequest>(
            data, contentSize);

        if(request.rt_session_id() == 0)
        {
            throw InvalidArgumentError("Invalid session id");
        }

        // RepeatedPtrField を vector に変換
        std::vector<std::string> parameterIds;
        for(const auto& id : request.parameter_sync_keys())
        {
            parameterIds.push_back(id);
        }

        // セッションの存在確認とパラメーター同期の停止
        _sessionManager.stopParameterSync(request.rt_session_id(),
                                          parameterIds);

        pb::StopParameterSyncResponse response;
        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_STOP_PARAMETER_SYNC_RESPONSE,
            context);
    }
    else if(bodyType == pb::BodyType::BODY_TYPE_RESET_STATE_REQUEST)
    {
        auto request =
            deserializePbMessage<pb::ResetStateRequest>(data, contentSize);

        _engine.resetState();

        pb::ResetStateResponse response;

        _dispatcher->sendMessage(
            response, pb::BodyType::BODY_TYPE_RESET_STATE_RESPONSE, context);
    }
    else
    {
        throw InvalidArgumentError{"Engine received unsupported body type (" +
                                   std::to_string(bodyType) + ")."};
    }
}

void HandlerV1Alpha1::sendErrorMessage(const Error& error,
                                       const pb::Struct& context)
{
    pb::EngineError msg;
    msg.set_message(error.description);

    switch(error.code)
    {
        case Error::Code::OK:
            msg.set_code(0);  // OK
            break;
        case Error::Code::CANCELLED:
            msg.set_code(1);  // CANCELLED
            break;
        case Error::Code::UNKNOWN:
            msg.set_code(2);  // UNKNOWN
            break;
        case Error::Code::INVALID_ARGUMENT:
            msg.set_code(3);  // INVALID_ARGUMENT
            break;
        case Error::Code::DEADLINE_EXCEEDED:
            msg.set_code(4);  // DEADLINE_EXCEEDED
            break;
        case Error::Code::NOT_FOUND:
            msg.set_code(5);  // NOT_FOUND
            break;
        case Error::Code::ALREADY_EXISTS:
            msg.set_code(6);  // ALREADY_EXISTS
            break;
        case Error::Code::PERMISSION_DENIED:
            msg.set_code(7);  // PERMISSION_DENIED
            break;
        case Error::Code::RESOURCE_EXHAUSTED:
            msg.set_code(8);  // RESOURCE_EXHAUSTED
            break;
        case Error::Code::FAILED_PRECONDITION:
            msg.set_code(9);  // FAILED_PRECONDITION
            break;
        case Error::Code::ABORTED:
            msg.set_code(10);  // ABORTED
            break;
        case Error::Code::OUT_OF_RANGE:
            msg.set_code(11);  // OUT_OF_RANGE
            break;
        case Error::Code::UNIMPLEMENTED:
            msg.set_code(12);  // UNIMPLEMENTED
            break;
        case Error::Code::INTERNAL:
            msg.set_code(13);  // INTERNAL
            break;
        case Error::Code::UNAVAILABLE:
            msg.set_code(14);  // UNAVAILABLE
            break;
        case Error::Code::DATA_LOSS:
            msg.set_code(15);  // DATA_LOSS
            break;
        case Error::Code::UNAUTHENTICATED:
            msg.set_code(16);  // UNAUTHENTICATED
            break;
        default:
            msg.set_code(2);  // UNKNOWN as fallback
            break;
    }

    _dispatcher->sendMessage(msg, pb::BodyType::BODY_TYPE_ENGINE_ERROR,
                             context);
}
}  // namespace novonotes
