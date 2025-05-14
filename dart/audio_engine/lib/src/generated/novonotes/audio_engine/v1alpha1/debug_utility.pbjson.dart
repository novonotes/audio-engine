//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/debug_utility.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use debugStateRequestDescriptor instead')
const DebugStateRequest$json = {
  '1': 'DebugStateRequest',
};

/// Descriptor for `DebugStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debugStateRequestDescriptor =
    $convert.base64Decode('ChFEZWJ1Z1N0YXRlUmVxdWVzdA==');

@$core.Deprecated('Use debugStateResponseDescriptor instead')
const DebugStateResponse$json = {
  '1': 'DebugStateResponse',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 9, '10': 'state'},
  ],
};

/// Descriptor for `DebugStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debugStateResponseDescriptor = $convert
    .base64Decode('ChJEZWJ1Z1N0YXRlUmVzcG9uc2USFAoFc3RhdGUYASABKAlSBXN0YXRl');

@$core.Deprecated('Use saveStateRequestDescriptor instead')
const SaveStateRequest$json = {
  '1': 'SaveStateRequest',
  '2': [
    {
      '1': 'dest_file_path',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'destFilePath'
    },
  ],
};

/// Descriptor for `SaveStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveStateRequestDescriptor = $convert.base64Decode(
    'ChBTYXZlU3RhdGVSZXF1ZXN0EikKDmRlc3RfZmlsZV9wYXRoGAEgASgJQgPgQQJSDGRlc3RGaW'
    'xlUGF0aA==');

@$core.Deprecated('Use saveStateResponseDescriptor instead')
const SaveStateResponse$json = {
  '1': 'SaveStateResponse',
};

/// Descriptor for `SaveStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveStateResponseDescriptor =
    $convert.base64Decode('ChFTYXZlU3RhdGVSZXNwb25zZQ==');
