//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/engine_management.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use initializeRequestDescriptor instead')
const InitializeRequest$json = {
  '1': 'InitializeRequest',
  '2': [
    {'1': 'app_instance_id', '3': 1, '4': 1, '5': 9, '10': 'appInstanceId'},
    {'1': 'schema_version', '3': 2, '4': 1, '5': 9, '10': 'schemaVersion'},
  ],
};

/// Descriptor for `InitializeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initializeRequestDescriptor = $convert.base64Decode(
    'ChFJbml0aWFsaXplUmVxdWVzdBImCg9hcHBfaW5zdGFuY2VfaWQYASABKAlSDWFwcEluc3Rhbm'
    'NlSWQSJQoOc2NoZW1hX3ZlcnNpb24YAiABKAlSDXNjaGVtYVZlcnNpb24=');

@$core.Deprecated('Use initializeResponseDescriptor instead')
const InitializeResponse$json = {
  '1': 'InitializeResponse',
  '2': [
    {'1': 'engine_type_id', '3': 3, '4': 1, '5': 9, '10': 'engineTypeId'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'schema_version', '3': 6, '4': 1, '5': 9, '10': 'schemaVersion'},
    {'1': 'pid', '3': 7, '4': 1, '5': 5, '10': 'pid'},
  ],
};

/// Descriptor for `InitializeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initializeResponseDescriptor = $convert.base64Decode(
    'ChJJbml0aWFsaXplUmVzcG9uc2USJAoOZW5naW5lX3R5cGVfaWQYAyABKAlSDGVuZ2luZVR5cG'
    'VJZBIhCgxkaXNwbGF5X25hbWUYBCABKAlSC2Rpc3BsYXlOYW1lEiUKDnNjaGVtYV92ZXJzaW9u'
    'GAYgASgJUg1zY2hlbWFWZXJzaW9uEhAKA3BpZBgHIAEoBVIDcGlk');

@$core.Deprecated('Use shutdownRequestDescriptor instead')
const ShutdownRequest$json = {
  '1': 'ShutdownRequest',
};

/// Descriptor for `ShutdownRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shutdownRequestDescriptor =
    $convert.base64Decode('Cg9TaHV0ZG93blJlcXVlc3Q=');

@$core.Deprecated('Use shutdownResponseDescriptor instead')
const ShutdownResponse$json = {
  '1': 'ShutdownResponse',
};

/// Descriptor for `ShutdownResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shutdownResponseDescriptor =
    $convert.base64Decode('ChBTaHV0ZG93blJlc3BvbnNl');

@$core.Deprecated('Use resetStateRequestDescriptor instead')
const ResetStateRequest$json = {
  '1': 'ResetStateRequest',
};

/// Descriptor for `ResetStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetStateRequestDescriptor =
    $convert.base64Decode('ChFSZXNldFN0YXRlUmVxdWVzdA==');

@$core.Deprecated('Use resetStateResponseDescriptor instead')
const ResetStateResponse$json = {
  '1': 'ResetStateResponse',
};

/// Descriptor for `ResetStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetStateResponseDescriptor =
    $convert.base64Decode('ChJSZXNldFN0YXRlUmVzcG9uc2U=');

@$core.Deprecated('Use playTestToneRequestDescriptor instead')
const PlayTestToneRequest$json = {
  '1': 'PlayTestToneRequest',
};

/// Descriptor for `PlayTestToneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playTestToneRequestDescriptor =
    $convert.base64Decode('ChNQbGF5VGVzdFRvbmVSZXF1ZXN0');

@$core.Deprecated('Use playTestToneResponseDescriptor instead')
const PlayTestToneResponse$json = {
  '1': 'PlayTestToneResponse',
};

/// Descriptor for `PlayTestToneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playTestToneResponseDescriptor =
    $convert.base64Decode('ChRQbGF5VGVzdFRvbmVSZXNwb25zZQ==');
