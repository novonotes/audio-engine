//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/connection.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use connectionDescriptor instead')
const Connection$json = {
  '1': 'Connection',
  '2': [
    {
      '1': 'src_audio_track_id',
      '3': 101,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'srcAudioTrackId'
    },
    {
      '1': 'src_device_id',
      '3': 103,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'srcDeviceId'
    },
    {
      '1': 'dest_audio_output',
      '3': 201,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Empty',
      '9': 1,
      '10': 'destAudioOutput'
    },
    {
      '1': 'dest_device_id',
      '3': 202,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'destDeviceId'
    },
  ],
  '8': [
    {'1': 'source'},
    {'1': 'destination'},
  ],
};

/// Descriptor for `Connection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDescriptor = $convert.base64Decode(
    'CgpDb25uZWN0aW9uEi0KEnNyY19hdWRpb190cmFja19pZBhlIAEoCUgAUg9zcmNBdWRpb1RyYW'
    'NrSWQSJAoNc3JjX2RldmljZV9pZBhnIAEoCUgAUgtzcmNEZXZpY2VJZBJFChFkZXN0X2F1ZGlv'
    'X291dHB1dBjJASABKAsyFi5nb29nbGUucHJvdG9idWYuRW1wdHlIAVIPZGVzdEF1ZGlvT3V0cH'
    'V0EicKDmRlc3RfZGV2aWNlX2lkGMoBIAEoCUgBUgxkZXN0RGV2aWNlSWRCCAoGc291cmNlQg0K'
    'C2Rlc3RpbmF0aW9u');

@$core.Deprecated('Use connectRequestDescriptor instead')
const ConnectRequest$json = {
  '1': 'ConnectRequest',
  '2': [
    {
      '1': 'connection',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.Connection',
      '8': {},
      '10': 'connection'
    },
  ],
};

/// Descriptor for `ConnectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectRequestDescriptor = $convert.base64Decode(
    'Cg5Db25uZWN0UmVxdWVzdBJQCgpjb25uZWN0aW9uGAIgASgLMisubm92b25vdGVzLmF1ZGlvX2'
    'VuZ2luZS52MWFscGhhMS5Db25uZWN0aW9uQgPgQQJSCmNvbm5lY3Rpb24=');

@$core.Deprecated('Use connectResponseDescriptor instead')
const ConnectResponse$json = {
  '1': 'ConnectResponse',
};

/// Descriptor for `ConnectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectResponseDescriptor =
    $convert.base64Decode('Cg9Db25uZWN0UmVzcG9uc2U=');

@$core.Deprecated('Use disconnectRequestDescriptor instead')
const DisconnectRequest$json = {
  '1': 'DisconnectRequest',
  '2': [
    {
      '1': 'connection',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.Connection',
      '8': {},
      '10': 'connection'
    },
  ],
};

/// Descriptor for `DisconnectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectRequestDescriptor = $convert.base64Decode(
    'ChFEaXNjb25uZWN0UmVxdWVzdBJQCgpjb25uZWN0aW9uGAIgASgLMisubm92b25vdGVzLmF1ZG'
    'lvX2VuZ2luZS52MWFscGhhMS5Db25uZWN0aW9uQgPgQQJSCmNvbm5lY3Rpb24=');

@$core.Deprecated('Use disconnectResponseDescriptor instead')
const DisconnectResponse$json = {
  '1': 'DisconnectResponse',
};

/// Descriptor for `DisconnectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectResponseDescriptor =
    $convert.base64Decode('ChJEaXNjb25uZWN0UmVzcG9uc2U=');
