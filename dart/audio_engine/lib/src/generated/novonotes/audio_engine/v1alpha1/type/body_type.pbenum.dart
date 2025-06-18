//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/type/body_type.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// それぞれの値は message の名前を、厳密に SNAKE_CASE に変換した名前にすること。
class BodyType extends $pb.ProtobufEnum {
  /// buf:lint:ignore ENUM_ZERO_VALUE_SUFFIX
  static const BodyType BODY_TYPE_HANDSHAKE =
      BodyType._(0, _omitEnumNames ? '' : 'BODY_TYPE_HANDSHAKE');
  static const BodyType BODY_TYPE_CREATE_AUDIO_REGION_REQUEST = BodyType._(
      31, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_AUDIO_REGION_REQUEST');
  static const BodyType BODY_TYPE_CREATE_AUDIO_REGION_RESPONSE = BodyType._(
      32, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_AUDIO_REGION_RESPONSE');
  static const BodyType BODY_TYPE_UPDATE_AUDIO_REGION_REQUEST = BodyType._(
      33, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_AUDIO_REGION_REQUEST');
  static const BodyType BODY_TYPE_UPDATE_AUDIO_REGION_RESPONSE = BodyType._(
      34, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_AUDIO_REGION_RESPONSE');
  static const BodyType BODY_TYPE_DELETE_AUDIO_REGION_REQUEST = BodyType._(
      35, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_AUDIO_REGION_REQUEST');
  static const BodyType BODY_TYPE_DELETE_AUDIO_REGION_RESPONSE = BodyType._(
      36, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_AUDIO_REGION_RESPONSE');
  static const BodyType BODY_TYPE_CREATE_TRACK_REQUEST =
      BodyType._(37, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_TRACK_REQUEST');
  static const BodyType BODY_TYPE_CREATE_TRACK_RESPONSE =
      BodyType._(38, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_TRACK_RESPONSE');
  static const BodyType BODY_TYPE_UPDATE_TRACK_REQUEST =
      BodyType._(39, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_TRACK_REQUEST');
  static const BodyType BODY_TYPE_UPDATE_TRACK_RESPONSE =
      BodyType._(40, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_TRACK_RESPONSE');
  static const BodyType BODY_TYPE_DELETE_TRACK_REQUEST =
      BodyType._(41, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_TRACK_REQUEST');
  static const BodyType BODY_TYPE_DELETE_TRACK_RESPONSE =
      BodyType._(42, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_TRACK_RESPONSE');
  static const BodyType BODY_TYPE_CONNECT_REQUEST =
      BodyType._(43, _omitEnumNames ? '' : 'BODY_TYPE_CONNECT_REQUEST');
  static const BodyType BODY_TYPE_CONNECT_RESPONSE =
      BodyType._(44, _omitEnumNames ? '' : 'BODY_TYPE_CONNECT_RESPONSE');
  static const BodyType BODY_TYPE_DISCONNECT_REQUEST =
      BodyType._(45, _omitEnumNames ? '' : 'BODY_TYPE_DISCONNECT_REQUEST');
  static const BodyType BODY_TYPE_DISCONNECT_RESPONSE =
      BodyType._(46, _omitEnumNames ? '' : 'BODY_TYPE_DISCONNECT_RESPONSE');
  static const BodyType BODY_TYPE_DEBUG_STATE_REQUEST =
      BodyType._(47, _omitEnumNames ? '' : 'BODY_TYPE_DEBUG_STATE_REQUEST');
  static const BodyType BODY_TYPE_DEBUG_STATE_RESPONSE =
      BodyType._(48, _omitEnumNames ? '' : 'BODY_TYPE_DEBUG_STATE_RESPONSE');
  static const BodyType BODY_TYPE_SAVE_STATE_REQUEST =
      BodyType._(49, _omitEnumNames ? '' : 'BODY_TYPE_SAVE_STATE_REQUEST');
  static const BodyType BODY_TYPE_SAVE_STATE_RESPONSE =
      BodyType._(50, _omitEnumNames ? '' : 'BODY_TYPE_SAVE_STATE_RESPONSE');
  static const BodyType BODY_TYPE_CREATE_DEVICE_INSTANCE_REQUEST = BodyType._(
      51, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_DEVICE_INSTANCE_REQUEST');
  static const BodyType BODY_TYPE_CREATE_DEVICE_INSTANCE_RESPONSE = BodyType._(
      52, _omitEnumNames ? '' : 'BODY_TYPE_CREATE_DEVICE_INSTANCE_RESPONSE');
  static const BodyType BODY_TYPE_DELETE_DEVICE_INSTANCE_REQUEST = BodyType._(
      55, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_DEVICE_INSTANCE_REQUEST');
  static const BodyType BODY_TYPE_DELETE_DEVICE_INSTANCE_RESPONSE = BodyType._(
      56, _omitEnumNames ? '' : 'BODY_TYPE_DELETE_DEVICE_INSTANCE_RESPONSE');
  static const BodyType BODY_TYPE_INITIALIZE_REQUEST =
      BodyType._(57, _omitEnumNames ? '' : 'BODY_TYPE_INITIALIZE_REQUEST');
  static const BodyType BODY_TYPE_INITIALIZE_RESPONSE =
      BodyType._(58, _omitEnumNames ? '' : 'BODY_TYPE_INITIALIZE_RESPONSE');
  static const BodyType BODY_TYPE_SHUTDOWN_REQUEST =
      BodyType._(61, _omitEnumNames ? '' : 'BODY_TYPE_SHUTDOWN_REQUEST');
  static const BodyType BODY_TYPE_SHUTDOWN_RESPONSE =
      BodyType._(62, _omitEnumNames ? '' : 'BODY_TYPE_SHUTDOWN_RESPONSE');
  static const BodyType BODY_TYPE_START_PLAYBACK_REQUEST =
      BodyType._(63, _omitEnumNames ? '' : 'BODY_TYPE_START_PLAYBACK_REQUEST');
  static const BodyType BODY_TYPE_START_PLAYBACK_RESPONSE =
      BodyType._(64, _omitEnumNames ? '' : 'BODY_TYPE_START_PLAYBACK_RESPONSE');
  static const BodyType BODY_TYPE_STOP_PLAYBACK_REQUEST =
      BodyType._(65, _omitEnumNames ? '' : 'BODY_TYPE_STOP_PLAYBACK_REQUEST');
  static const BodyType BODY_TYPE_STOP_PLAYBACK_RESPONSE =
      BodyType._(66, _omitEnumNames ? '' : 'BODY_TYPE_STOP_PLAYBACK_RESPONSE');
  static const BodyType BODY_TYPE_UPDATE_TRANSPORT_REQUEST = BodyType._(
      67, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_TRANSPORT_REQUEST');
  static const BodyType BODY_TYPE_UPDATE_TRANSPORT_RESPONSE = BodyType._(
      68, _omitEnumNames ? '' : 'BODY_TYPE_UPDATE_TRANSPORT_RESPONSE');
  static const BodyType BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_REQUEST =
      BodyType._(
          69,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_REQUEST');
  static const BodyType BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_RESPONSE =
      BodyType._(
          70,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_RESPONSE');
  static const BodyType BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_REQUEST =
      BodyType._(
          71,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_REQUEST');
  static const BodyType BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_RESPONSE =
      BodyType._(
          72,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_RESPONSE');
  static const BodyType BODY_TYPE_RT_PLAYHEAD_POSITION =
      BodyType._(73, _omitEnumNames ? '' : 'BODY_TYPE_RT_PLAYHEAD_POSITION');
  static const BodyType BODY_TYPE_PLAY_TEST_TONE_REQUEST =
      BodyType._(74, _omitEnumNames ? '' : 'BODY_TYPE_PLAY_TEST_TONE_REQUEST');
  static const BodyType BODY_TYPE_PLAY_TEST_TONE_RESPONSE =
      BodyType._(75, _omitEnumNames ? '' : 'BODY_TYPE_PLAY_TEST_TONE_RESPONSE');
  static const BodyType BODY_TYPE_START_PARAMETER_SYNC_REQUEST = BodyType._(
      76, _omitEnumNames ? '' : 'BODY_TYPE_START_PARAMETER_SYNC_REQUEST');
  static const BodyType BODY_TYPE_START_PARAMETER_SYNC_RESPONSE = BodyType._(
      77, _omitEnumNames ? '' : 'BODY_TYPE_START_PARAMETER_SYNC_RESPONSE');
  static const BodyType BODY_TYPE_STOP_PARAMETER_SYNC_REQUEST = BodyType._(
      78, _omitEnumNames ? '' : 'BODY_TYPE_STOP_PARAMETER_SYNC_REQUEST');
  static const BodyType BODY_TYPE_STOP_PARAMETER_SYNC_RESPONSE = BodyType._(
      79, _omitEnumNames ? '' : 'BODY_TYPE_STOP_PARAMETER_SYNC_RESPONSE');
  static const BodyType BODY_TYPE_RT_UPDATE_PARAMETER_COMMAND = BodyType._(
      80, _omitEnumNames ? '' : 'BODY_TYPE_RT_UPDATE_PARAMETER_COMMAND');
  static const BodyType BODY_TYPE_RT_FINALIZE_PARAMETER_COMMAND = BodyType._(
      81, _omitEnumNames ? '' : 'BODY_TYPE_RT_FINALIZE_PARAMETER_COMMAND');
  static const BodyType BODY_TYPE_RT_PARAMETER =
      BodyType._(82, _omitEnumNames ? '' : 'BODY_TYPE_RT_PARAMETER');
  static const BodyType BODY_TYPE_START_RT_SESSION_REQUEST = BodyType._(
      83, _omitEnumNames ? '' : 'BODY_TYPE_START_RT_SESSION_REQUEST');
  static const BodyType BODY_TYPE_START_RT_SESSION_RESPONSE = BodyType._(
      84, _omitEnumNames ? '' : 'BODY_TYPE_START_RT_SESSION_RESPONSE');
  static const BodyType BODY_TYPE_STOP_RT_SESSION_REQUEST =
      BodyType._(85, _omitEnumNames ? '' : 'BODY_TYPE_STOP_RT_SESSION_REQUEST');
  static const BodyType BODY_TYPE_STOP_RT_SESSION_RESPONSE = BodyType._(
      86, _omitEnumNames ? '' : 'BODY_TYPE_STOP_RT_SESSION_RESPONSE');
  static const BodyType BODY_TYPE_LIST_DEVICE_DESCRIPTORS_REQUEST = BodyType._(
      87, _omitEnumNames ? '' : 'BODY_TYPE_LIST_DEVICE_DESCRIPTORS_REQUEST');
  static const BodyType BODY_TYPE_LIST_DEVICE_DESCRIPTORS_RESPONSE = BodyType._(
      88, _omitEnumNames ? '' : 'BODY_TYPE_LIST_DEVICE_DESCRIPTORS_RESPONSE');
  static const BodyType BODY_TYPE_GET_DEVICE_INSTANCE_REQUEST = BodyType._(
      89, _omitEnumNames ? '' : 'BODY_TYPE_GET_DEVICE_INSTANCE_REQUEST');
  static const BodyType BODY_TYPE_GET_DEVICE_INSTANCE_RESPONSE = BodyType._(
      90, _omitEnumNames ? '' : 'BODY_TYPE_GET_DEVICE_INSTANCE_RESPONSE');
  static const BodyType BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_REQUEST =
      BodyType._(
          91,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_REQUEST');
  static const BodyType
      BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_RESPONSE = BodyType._(
          92,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_RESPONSE');
  static const BodyType BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_REQUEST =
      BodyType._(
          93,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_REQUEST');
  static const BodyType BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_RESPONSE =
      BodyType._(
          94,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_RESPONSE');
  static const BodyType BODY_TYPE_SET_PARAMETER_VALUE_REQUEST = BodyType._(
      95, _omitEnumNames ? '' : 'BODY_TYPE_SET_PARAMETER_VALUE_REQUEST');
  static const BodyType BODY_TYPE_SET_PARAMETER_VALUE_RESPONSE = BodyType._(
      96, _omitEnumNames ? '' : 'BODY_TYPE_SET_PARAMETER_VALUE_RESPONSE');
  static const BodyType BODY_TYPE_BATCH_SET_PARAMETER_VALUES_REQUEST =
      BodyType._(97,
          _omitEnumNames ? '' : 'BODY_TYPE_BATCH_SET_PARAMETER_VALUES_REQUEST');
  static const BodyType BODY_TYPE_BATCH_SET_PARAMETER_VALUES_RESPONSE =
      BodyType._(
          98,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_BATCH_SET_PARAMETER_VALUES_RESPONSE');
  static const BodyType BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_REQUEST =
      BodyType._(
          99,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_REQUEST');
  static const BodyType BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_RESPONSE =
      BodyType._(
          100,
          _omitEnumNames
              ? ''
              : 'BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_RESPONSE');
  static const BodyType BODY_TYPE_RESET_STATE_REQUEST =
      BodyType._(101, _omitEnumNames ? '' : 'BODY_TYPE_RESET_STATE_REQUEST');
  static const BodyType BODY_TYPE_RESET_STATE_RESPONSE =
      BodyType._(102, _omitEnumNames ? '' : 'BODY_TYPE_RESET_STATE_RESPONSE');
  static const BodyType BODY_TYPE_ENGINE_ERROR =
      BodyType._(1001, _omitEnumNames ? '' : 'BODY_TYPE_ENGINE_ERROR');

  static const $core.List<BodyType> values = <BodyType>[
    BODY_TYPE_HANDSHAKE,
    BODY_TYPE_CREATE_AUDIO_REGION_REQUEST,
    BODY_TYPE_CREATE_AUDIO_REGION_RESPONSE,
    BODY_TYPE_UPDATE_AUDIO_REGION_REQUEST,
    BODY_TYPE_UPDATE_AUDIO_REGION_RESPONSE,
    BODY_TYPE_DELETE_AUDIO_REGION_REQUEST,
    BODY_TYPE_DELETE_AUDIO_REGION_RESPONSE,
    BODY_TYPE_CREATE_TRACK_REQUEST,
    BODY_TYPE_CREATE_TRACK_RESPONSE,
    BODY_TYPE_UPDATE_TRACK_REQUEST,
    BODY_TYPE_UPDATE_TRACK_RESPONSE,
    BODY_TYPE_DELETE_TRACK_REQUEST,
    BODY_TYPE_DELETE_TRACK_RESPONSE,
    BODY_TYPE_CONNECT_REQUEST,
    BODY_TYPE_CONNECT_RESPONSE,
    BODY_TYPE_DISCONNECT_REQUEST,
    BODY_TYPE_DISCONNECT_RESPONSE,
    BODY_TYPE_DEBUG_STATE_REQUEST,
    BODY_TYPE_DEBUG_STATE_RESPONSE,
    BODY_TYPE_SAVE_STATE_REQUEST,
    BODY_TYPE_SAVE_STATE_RESPONSE,
    BODY_TYPE_CREATE_DEVICE_INSTANCE_REQUEST,
    BODY_TYPE_CREATE_DEVICE_INSTANCE_RESPONSE,
    BODY_TYPE_DELETE_DEVICE_INSTANCE_REQUEST,
    BODY_TYPE_DELETE_DEVICE_INSTANCE_RESPONSE,
    BODY_TYPE_INITIALIZE_REQUEST,
    BODY_TYPE_INITIALIZE_RESPONSE,
    BODY_TYPE_SHUTDOWN_REQUEST,
    BODY_TYPE_SHUTDOWN_RESPONSE,
    BODY_TYPE_START_PLAYBACK_REQUEST,
    BODY_TYPE_START_PLAYBACK_RESPONSE,
    BODY_TYPE_STOP_PLAYBACK_REQUEST,
    BODY_TYPE_STOP_PLAYBACK_RESPONSE,
    BODY_TYPE_UPDATE_TRANSPORT_REQUEST,
    BODY_TYPE_UPDATE_TRANSPORT_RESPONSE,
    BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_REQUEST,
    BODY_TYPE_START_PLAYHEAD_POSITION_STREAM_RESPONSE,
    BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_REQUEST,
    BODY_TYPE_STOP_PLAYHEAD_POSITION_STREAM_RESPONSE,
    BODY_TYPE_RT_PLAYHEAD_POSITION,
    BODY_TYPE_PLAY_TEST_TONE_REQUEST,
    BODY_TYPE_PLAY_TEST_TONE_RESPONSE,
    BODY_TYPE_START_PARAMETER_SYNC_REQUEST,
    BODY_TYPE_START_PARAMETER_SYNC_RESPONSE,
    BODY_TYPE_STOP_PARAMETER_SYNC_REQUEST,
    BODY_TYPE_STOP_PARAMETER_SYNC_RESPONSE,
    BODY_TYPE_RT_UPDATE_PARAMETER_COMMAND,
    BODY_TYPE_RT_FINALIZE_PARAMETER_COMMAND,
    BODY_TYPE_RT_PARAMETER,
    BODY_TYPE_START_RT_SESSION_REQUEST,
    BODY_TYPE_START_RT_SESSION_RESPONSE,
    BODY_TYPE_STOP_RT_SESSION_REQUEST,
    BODY_TYPE_STOP_RT_SESSION_RESPONSE,
    BODY_TYPE_LIST_DEVICE_DESCRIPTORS_REQUEST,
    BODY_TYPE_LIST_DEVICE_DESCRIPTORS_RESPONSE,
    BODY_TYPE_GET_DEVICE_INSTANCE_REQUEST,
    BODY_TYPE_GET_DEVICE_INSTANCE_RESPONSE,
    BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_REQUEST,
    BODY_TYPE_SUBSCRIBE_TO_DEVICE_INSTANCE_UPDATES_RESPONSE,
    BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_REQUEST,
    BODY_TYPE_RESTORE_DEVICE_INSTANCE_STATE_RESPONSE,
    BODY_TYPE_SET_PARAMETER_VALUE_REQUEST,
    BODY_TYPE_SET_PARAMETER_VALUE_RESPONSE,
    BODY_TYPE_BATCH_SET_PARAMETER_VALUES_REQUEST,
    BODY_TYPE_BATCH_SET_PARAMETER_VALUES_RESPONSE,
    BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_REQUEST,
    BODY_TYPE_EXECUTE_DEVICE_SPECIFIC_COMMAND_RESPONSE,
    BODY_TYPE_RESET_STATE_REQUEST,
    BODY_TYPE_RESET_STATE_RESPONSE,
    BODY_TYPE_ENGINE_ERROR,
  ];

  static final $core.Map<$core.int, BodyType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static BodyType? valueOf($core.int value) => _byValue[value];

  const BodyType._(super.v, super.n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
