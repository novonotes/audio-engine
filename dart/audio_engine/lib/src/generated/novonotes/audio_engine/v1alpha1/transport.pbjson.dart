//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/transport.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = {
  '1': 'Transport',
  '2': [
    {'1': 'tempo', '3': 1, '4': 1, '5': 1, '10': 'tempo'},
    {
      '1': 'playhead_position',
      '3': 2,
      '4': 1,
      '5': 1,
      '10': 'playheadPosition'
    },
    {'1': 'loop_start', '3': 3, '4': 1, '5': 1, '10': 'loopStart'},
    {'1': 'loop_duration', '3': 4, '4': 1, '5': 1, '10': 'loopDuration'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode(
    'CglUcmFuc3BvcnQSFAoFdGVtcG8YASABKAFSBXRlbXBvEisKEXBsYXloZWFkX3Bvc2l0aW9uGA'
    'IgASgBUhBwbGF5aGVhZFBvc2l0aW9uEh0KCmxvb3Bfc3RhcnQYAyABKAFSCWxvb3BTdGFydBIj'
    'Cg1sb29wX2R1cmF0aW9uGAQgASgBUgxsb29wRHVyYXRpb24=');

@$core.Deprecated('Use updateTransportRequestDescriptor instead')
const UpdateTransportRequest$json = {
  '1': 'UpdateTransportRequest',
  '2': [
    {
      '1': 'transport',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.Transport',
      '8': {},
      '10': 'transport'
    },
    {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateTransportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransportRequestDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVUcmFuc3BvcnRSZXF1ZXN0Ek0KCXRyYW5zcG9ydBgBIAEoCzIqLm5vdm9ub3Rlcy'
    '5hdWRpb19lbmdpbmUudjFhbHBoYTEuVHJhbnNwb3J0QgPgQQJSCXRyYW5zcG9ydBJACgt1cGRh'
    'dGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tCA+BBAlIKdXBkYXRlTW'
    'Fzaw==');

@$core.Deprecated('Use updateTransportResponseDescriptor instead')
const UpdateTransportResponse$json = {
  '1': 'UpdateTransportResponse',
};

/// Descriptor for `UpdateTransportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTransportResponseDescriptor =
    $convert.base64Decode('ChdVcGRhdGVUcmFuc3BvcnRSZXNwb25zZQ==');

@$core.Deprecated('Use startPlaybackRequestDescriptor instead')
const StartPlaybackRequest$json = {
  '1': 'StartPlaybackRequest',
};

/// Descriptor for `StartPlaybackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startPlaybackRequestDescriptor =
    $convert.base64Decode('ChRTdGFydFBsYXliYWNrUmVxdWVzdA==');

@$core.Deprecated('Use startPlaybackResponseDescriptor instead')
const StartPlaybackResponse$json = {
  '1': 'StartPlaybackResponse',
};

/// Descriptor for `StartPlaybackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startPlaybackResponseDescriptor =
    $convert.base64Decode('ChVTdGFydFBsYXliYWNrUmVzcG9uc2U=');

@$core.Deprecated('Use stopPlaybackRequestDescriptor instead')
const StopPlaybackRequest$json = {
  '1': 'StopPlaybackRequest',
};

/// Descriptor for `StopPlaybackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopPlaybackRequestDescriptor =
    $convert.base64Decode('ChNTdG9wUGxheWJhY2tSZXF1ZXN0');

@$core.Deprecated('Use stopPlaybackResponseDescriptor instead')
const StopPlaybackResponse$json = {
  '1': 'StopPlaybackResponse',
};

/// Descriptor for `StopPlaybackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopPlaybackResponseDescriptor =
    $convert.base64Decode('ChRTdG9wUGxheWJhY2tSZXNwb25zZQ==');

@$core.Deprecated('Use startPlayheadPositionStreamRequestDescriptor instead')
const StartPlayheadPositionStreamRequest$json = {
  '1': 'StartPlayheadPositionStreamRequest',
  '2': [
    {'1': 'rt_session_id', '3': 2, '4': 1, '5': 5, '10': 'rtSessionId'},
  ],
};

/// Descriptor for `StartPlayheadPositionStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startPlayheadPositionStreamRequestDescriptor =
    $convert.base64Decode(
        'CiJTdGFydFBsYXloZWFkUG9zaXRpb25TdHJlYW1SZXF1ZXN0EiIKDXJ0X3Nlc3Npb25faWQYAi'
        'ABKAVSC3J0U2Vzc2lvbklk');

@$core.Deprecated('Use startPlayheadPositionStreamResponseDescriptor instead')
const StartPlayheadPositionStreamResponse$json = {
  '1': 'StartPlayheadPositionStreamResponse',
};

/// Descriptor for `StartPlayheadPositionStreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startPlayheadPositionStreamResponseDescriptor =
    $convert
        .base64Decode('CiNTdGFydFBsYXloZWFkUG9zaXRpb25TdHJlYW1SZXNwb25zZQ==');

@$core.Deprecated('Use stopPlayheadPositionStreamRequestDescriptor instead')
const StopPlayheadPositionStreamRequest$json = {
  '1': 'StopPlayheadPositionStreamRequest',
  '2': [
    {'1': 'rt_session_id', '3': 1, '4': 1, '5': 5, '10': 'rtSessionId'},
  ],
};

/// Descriptor for `StopPlayheadPositionStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopPlayheadPositionStreamRequestDescriptor =
    $convert.base64Decode(
        'CiFTdG9wUGxheWhlYWRQb3NpdGlvblN0cmVhbVJlcXVlc3QSIgoNcnRfc2Vzc2lvbl9pZBgBIA'
        'EoBVILcnRTZXNzaW9uSWQ=');

@$core.Deprecated('Use stopPlayheadPositionStreamResponseDescriptor instead')
const StopPlayheadPositionStreamResponse$json = {
  '1': 'StopPlayheadPositionStreamResponse',
};

/// Descriptor for `StopPlayheadPositionStreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopPlayheadPositionStreamResponseDescriptor =
    $convert.base64Decode('CiJTdG9wUGxheWhlYWRQb3NpdGlvblN0cmVhbVJlc3BvbnNl');

@$core.Deprecated('Use rtPlayheadPositionDescriptor instead')
const RtPlayheadPosition$json = {
  '1': 'RtPlayheadPosition',
  '2': [
    {'1': 'sequence_number', '3': 1, '4': 1, '5': 5, '10': 'sequenceNumber'},
    {'1': 'position_ppq', '3': 2, '4': 1, '5': 1, '10': 'positionPpq'},
    {'1': 'position_seconds', '3': 3, '4': 1, '5': 1, '10': 'positionSeconds'},
    {'1': 'position_samples', '3': 4, '4': 1, '5': 3, '10': 'positionSamples'},
  ],
};

/// Descriptor for `RtPlayheadPosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtPlayheadPositionDescriptor = $convert.base64Decode(
    'ChJSdFBsYXloZWFkUG9zaXRpb24SJwoPc2VxdWVuY2VfbnVtYmVyGAEgASgFUg5zZXF1ZW5jZU'
    '51bWJlchIhCgxwb3NpdGlvbl9wcHEYAiABKAFSC3Bvc2l0aW9uUHBxEikKEHBvc2l0aW9uX3Nl'
    'Y29uZHMYAyABKAFSD3Bvc2l0aW9uU2Vjb25kcxIpChBwb3NpdGlvbl9zYW1wbGVzGAQgASgDUg'
    '9wb3NpdGlvblNhbXBsZXM=');
