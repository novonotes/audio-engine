//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/device_instance.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deviceInstanceDescriptor instead')
const DeviceInstance$json = {
  '1': 'DeviceInstance',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'device_type_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceTypeId'
    },
    {
      '1': 'state_restoration_token',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'stateRestorationToken'
    },
    {
      '1': 'parameters',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance.ParametersEntry',
      '8': {},
      '10': 'parameters'
    },
    {
      '1': 'inlets',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceIo',
      '8': {},
      '10': 'inlets'
    },
    {
      '1': 'outlets',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceIo',
      '8': {},
      '10': 'outlets'
    },
  ],
  '3': [DeviceInstance_ParametersEntry$json],
  '7': {},
};

@$core.Deprecated('Use deviceInstanceDescriptor instead')
const DeviceInstance_ParametersEntry$json = {
  '1': 'ParametersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceParameter',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `DeviceInstance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInstanceDescriptor = $convert.base64Decode(
    'Cg5EZXZpY2VJbnN0YW5jZRIWCgJpZBgBIAEoCUIG4EEI4EECUgJpZBIpCg5kZXZpY2VfdHlwZV'
    '9pZBgCIAEoCUID4EECUgxkZXZpY2VUeXBlSWQSOwoXc3RhdGVfcmVzdG9yYXRpb25fdG9rZW4Y'
    'AyABKAlCA+BBA1IVc3RhdGVSZXN0b3JhdGlvblRva2VuEmQKCnBhcmFtZXRlcnMYBCADKAsyPy'
    '5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLkRldmljZUluc3RhbmNlLlBhcmFtZXRl'
    'cnNFbnRyeUID4EEDUgpwYXJhbWV0ZXJzEkYKBmlubGV0cxgFIAMoCzIpLm5vdm9ub3Rlcy5hdW'
    'Rpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW9CA+BBA1IGaW5sZXRzEkgKB291dGxldHMYBiAD'
    'KAsyKS5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLkRldmljZUlvQgPgQQNSB291dG'
    'xldHMabwoPUGFyYW1ldGVyc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EkYKBXZhbHVlGAIgASgL'
    'MjAubm92b25vdGVzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5EZXZpY2VQYXJhbWV0ZXJSBXZhbH'
    'VlOgI4ATpO6kFLCihub3Zvbm90ZXMvYXVkaW8tZW5naW4tYXBpL0RldmljZUluc3RhbmNlKg9k'
    'ZXZpY2VJbnN0YW5jZXMyDmRldmljZUluc3RhbmNl');

@$core.Deprecated('Use deviceParameterDescriptor instead')
const DeviceParameter$json = {
  '1': 'DeviceParameter',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'displayName'},
    {
      '1': 'current_value',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'currentValue'
    },
    {
      '1': 'default_value',
      '3': 4,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'defaultValue'
    },
    {
      '1': 'parameter_sync_key',
      '3': 5,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'parameterSyncKey'
    },
    {
      '1': 'numeric',
      '3': 101,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceParameter.NumericType',
      '9': 0,
      '10': 'numeric'
    },
    {
      '1': 'choice',
      '3': 102,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceParameter.ChoiceType',
      '9': 0,
      '10': 'choice'
    },
  ],
  '3': [DeviceParameter_NumericType$json, DeviceParameter_ChoiceType$json],
  '8': [
    {'1': 'parameter_type'},
  ],
};

@$core.Deprecated('Use deviceParameterDescriptor instead')
const DeviceParameter_NumericType$json = {
  '1': 'NumericType',
  '2': [
    {
      '1': 'normalized_current_value',
      '3': 1,
      '4': 1,
      '5': 1,
      '8': {},
      '10': 'normalizedCurrentValue'
    },
    {
      '1': 'normalized_default_value',
      '3': 2,
      '4': 1,
      '5': 1,
      '8': {},
      '10': 'normalizedDefaultValue'
    },
    {'1': 'min_value', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'minValue'},
    {'1': 'max_value', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'maxValue'},
    {'1': 'step_count', '3': 5, '4': 1, '5': 5, '8': {}, '10': 'stepCount'},
  ],
};

@$core.Deprecated('Use deviceParameterDescriptor instead')
const DeviceParameter_ChoiceType$json = {
  '1': 'ChoiceType',
  '2': [
    {'1': 'options', '3': 1, '4': 3, '5': 9, '8': {}, '10': 'options'},
  ],
};

/// Descriptor for `DeviceParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceParameterDescriptor = $convert.base64Decode(
    'Cg9EZXZpY2VQYXJhbWV0ZXISEwoCaWQYASABKAlCA+BBA1ICaWQSJgoMZGlzcGxheV9uYW1lGA'
    'IgASgJQgPgQQNSC2Rpc3BsYXlOYW1lEigKDWN1cnJlbnRfdmFsdWUYAyABKAlCA+BBAVIMY3Vy'
    'cmVudFZhbHVlEigKDWRlZmF1bHRfdmFsdWUYBCABKAlCA+BBA1IMZGVmYXVsdFZhbHVlEjEKEn'
    'BhcmFtZXRlcl9zeW5jX2tleRgFIAEoCUID4EEDUhBwYXJhbWV0ZXJTeW5jS2V5ElgKB251bWVy'
    'aWMYZSABKAsyPC5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLkRldmljZVBhcmFtZX'
    'Rlci5OdW1lcmljVHlwZUgAUgdudW1lcmljElUKBmNob2ljZRhmIAEoCzI7Lm5vdm9ub3Rlcy5h'
    'dWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlUGFyYW1ldGVyLkNob2ljZVR5cGVIAFIGY2hvaW'
    'NlGvMBCgtOdW1lcmljVHlwZRI9Chhub3JtYWxpemVkX2N1cnJlbnRfdmFsdWUYASABKAFCA+BB'
    'AVIWbm9ybWFsaXplZEN1cnJlbnRWYWx1ZRI9Chhub3JtYWxpemVkX2RlZmF1bHRfdmFsdWUYAi'
    'ABKAFCA+BBA1IWbm9ybWFsaXplZERlZmF1bHRWYWx1ZRIgCgltaW5fdmFsdWUYAyABKAlCA+BB'
    'A1IIbWluVmFsdWUSIAoJbWF4X3ZhbHVlGAQgASgJQgPgQQNSCG1heFZhbHVlEiIKCnN0ZXBfY2'
    '91bnQYBSABKAVCA+BBA1IJc3RlcENvdW50GisKCkNob2ljZVR5cGUSHQoHb3B0aW9ucxgBIAMo'
    'CUID4EEDUgdvcHRpb25zQhAKDnBhcmFtZXRlcl90eXBl');

@$core.Deprecated('Use deviceIoDescriptor instead')
const DeviceIo$json = {
  '1': 'DeviceIo',
  '2': [
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'displayName'},
  ],
};

/// Descriptor for `DeviceIo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceIoDescriptor = $convert.base64Decode(
    'CghEZXZpY2VJbxImCgxkaXNwbGF5X25hbWUYAiABKAlCA+BBA1ILZGlzcGxheU5hbWU=');

@$core.Deprecated('Use createDeviceInstanceRequestDescriptor instead')
const CreateDeviceInstanceRequest$json = {
  '1': 'CreateDeviceInstanceRequest',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '8': {},
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `CreateDeviceInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDeviceInstanceRequestDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVEZXZpY2VJbnN0YW5jZVJlcXVlc3QSXQoPZGV2aWNlX2luc3RhbmNlGAEgASgLMi'
        '8ubm92b25vdGVzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5EZXZpY2VJbnN0YW5jZUID4EECUg5k'
        'ZXZpY2VJbnN0YW5jZQ==');

@$core.Deprecated('Use createDeviceInstanceResponseDescriptor instead')
const CreateDeviceInstanceResponse$json = {
  '1': 'CreateDeviceInstanceResponse',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `CreateDeviceInstanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createDeviceInstanceResponseDescriptor =
    $convert.base64Decode(
        'ChxDcmVhdGVEZXZpY2VJbnN0YW5jZVJlc3BvbnNlElgKD2RldmljZV9pbnN0YW5jZRgBIAEoCz'
        'IvLm5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW5zdGFuY2VSDmRldmlj'
        'ZUluc3RhbmNl');

@$core.Deprecated('Use deleteDeviceInstanceRequestDescriptor instead')
const DeleteDeviceInstanceRequest$json = {
  '1': 'DeleteDeviceInstanceRequest',
  '2': [
    {
      '1': 'device_instance_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceInstanceId'
    },
  ],
};

/// Descriptor for `DeleteDeviceInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDeviceInstanceRequestDescriptor =
    $convert.base64Decode(
        'ChtEZWxldGVEZXZpY2VJbnN0YW5jZVJlcXVlc3QSMQoSZGV2aWNlX2luc3RhbmNlX2lkGAEgAS'
        'gJQgPgQQJSEGRldmljZUluc3RhbmNlSWQ=');

@$core.Deprecated('Use deleteDeviceInstanceResponseDescriptor instead')
const DeleteDeviceInstanceResponse$json = {
  '1': 'DeleteDeviceInstanceResponse',
};

/// Descriptor for `DeleteDeviceInstanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDeviceInstanceResponseDescriptor =
    $convert.base64Decode('ChxEZWxldGVEZXZpY2VJbnN0YW5jZVJlc3BvbnNl');

@$core.Deprecated('Use getDeviceInstanceRequestDescriptor instead')
const GetDeviceInstanceRequest$json = {
  '1': 'GetDeviceInstanceRequest',
  '2': [
    {
      '1': 'device_instance_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceInstanceId'
    },
  ],
};

/// Descriptor for `GetDeviceInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceInstanceRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXREZXZpY2VJbnN0YW5jZVJlcXVlc3QSMQoSZGV2aWNlX2luc3RhbmNlX2lkGAEgASgJQg'
        'PgQQJSEGRldmljZUluc3RhbmNlSWQ=');

@$core.Deprecated('Use getDeviceInstanceResponseDescriptor instead')
const GetDeviceInstanceResponse$json = {
  '1': 'GetDeviceInstanceResponse',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `GetDeviceInstanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDeviceInstanceResponseDescriptor = $convert.base64Decode(
    'ChlHZXREZXZpY2VJbnN0YW5jZVJlc3BvbnNlElgKD2RldmljZV9pbnN0YW5jZRgBIAEoCzIvLm'
    '5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW5zdGFuY2VSDmRldmljZUlu'
    'c3RhbmNl');

@$core
    .Deprecated('Use subscribeToDeviceInstanceUpdatesRequestDescriptor instead')
const SubscribeToDeviceInstanceUpdatesRequest$json = {
  '1': 'SubscribeToDeviceInstanceUpdatesRequest',
};

/// Descriptor for `SubscribeToDeviceInstanceUpdatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeToDeviceInstanceUpdatesRequestDescriptor =
    $convert.base64Decode(
        'CidTdWJzY3JpYmVUb0RldmljZUluc3RhbmNlVXBkYXRlc1JlcXVlc3Q=');

@$core.Deprecated(
    'Use subscribeToDeviceInstanceUpdatesResponseDescriptor instead')
const SubscribeToDeviceInstanceUpdatesResponse$json = {
  '1': 'SubscribeToDeviceInstanceUpdatesResponse',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `SubscribeToDeviceInstanceUpdatesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeToDeviceInstanceUpdatesResponseDescriptor =
    $convert.base64Decode(
        'CihTdWJzY3JpYmVUb0RldmljZUluc3RhbmNlVXBkYXRlc1Jlc3BvbnNlElgKD2RldmljZV9pbn'
        'N0YW5jZRgBIAEoCzIvLm5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW5z'
        'dGFuY2VSDmRldmljZUluc3RhbmNl');

@$core.Deprecated('Use restoreDeviceInstanceStateRequestDescriptor instead')
const RestoreDeviceInstanceStateRequest$json = {
  '1': 'RestoreDeviceInstanceStateRequest',
  '2': [
    {
      '1': 'device_instance_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceInstanceId'
    },
    {
      '1': 'state_restoration_token',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'stateRestorationToken'
    },
  ],
};

/// Descriptor for `RestoreDeviceInstanceStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreDeviceInstanceStateRequestDescriptor =
    $convert.base64Decode(
        'CiFSZXN0b3JlRGV2aWNlSW5zdGFuY2VTdGF0ZVJlcXVlc3QSMQoSZGV2aWNlX2luc3RhbmNlX2'
        'lkGAEgASgJQgPgQQJSEGRldmljZUluc3RhbmNlSWQSOwoXc3RhdGVfcmVzdG9yYXRpb25fdG9r'
        'ZW4YAiABKAlCA+BBAlIVc3RhdGVSZXN0b3JhdGlvblRva2Vu');

@$core.Deprecated('Use restoreDeviceInstanceStateResponseDescriptor instead')
const RestoreDeviceInstanceStateResponse$json = {
  '1': 'RestoreDeviceInstanceStateResponse',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `RestoreDeviceInstanceStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreDeviceInstanceStateResponseDescriptor =
    $convert.base64Decode(
        'CiJSZXN0b3JlRGV2aWNlSW5zdGFuY2VTdGF0ZVJlc3BvbnNlElgKD2RldmljZV9pbnN0YW5jZR'
        'gBIAEoCzIvLm5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW5zdGFuY2VS'
        'DmRldmljZUluc3RhbmNl');

@$core.Deprecated('Use setParameterValueRequestDescriptor instead')
const SetParameterValueRequest$json = {
  '1': 'SetParameterValueRequest',
  '2': [
    {
      '1': 'device_instance_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceInstanceId'
    },
    {'1': 'parameter_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'parameterId'},
    {'1': 'text_value', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'textValue'},
    {
      '1': 'normalized_value',
      '3': 4,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'normalizedValue'
    },
  ],
  '8': [
    {'1': 'new_value'},
  ],
};

/// Descriptor for `SetParameterValueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setParameterValueRequestDescriptor = $convert.base64Decode(
    'ChhTZXRQYXJhbWV0ZXJWYWx1ZVJlcXVlc3QSMQoSZGV2aWNlX2luc3RhbmNlX2lkGAEgASgJQg'
    'PgQQJSEGRldmljZUluc3RhbmNlSWQSJgoMcGFyYW1ldGVyX2lkGAIgASgJQgPgQQJSC3BhcmFt'
    'ZXRlcklkEh8KCnRleHRfdmFsdWUYAyABKAlIAFIJdGV4dFZhbHVlEisKEG5vcm1hbGl6ZWRfdm'
    'FsdWUYBCABKAFIAFIPbm9ybWFsaXplZFZhbHVlQgsKCW5ld192YWx1ZQ==');

@$core.Deprecated('Use setParameterValueResponseDescriptor instead')
const SetParameterValueResponse$json = {
  '1': 'SetParameterValueResponse',
  '2': [
    {
      '1': 'device_instance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceInstance',
      '10': 'deviceInstance'
    },
  ],
};

/// Descriptor for `SetParameterValueResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setParameterValueResponseDescriptor = $convert.base64Decode(
    'ChlTZXRQYXJhbWV0ZXJWYWx1ZVJlc3BvbnNlElgKD2RldmljZV9pbnN0YW5jZRgBIAEoCzIvLm'
    '5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuRGV2aWNlSW5zdGFuY2VSDmRldmljZUlu'
    'c3RhbmNl');

@$core.Deprecated('Use batchSetParameterValuesRequestDescriptor instead')
const BatchSetParameterValuesRequest$json = {
  '1': 'BatchSetParameterValuesRequest',
  '2': [
    {
      '1': 'requests',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.SetParameterValueRequest',
      '8': {},
      '10': 'requests'
    },
  ],
};

/// Descriptor for `BatchSetParameterValuesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchSetParameterValuesRequestDescriptor =
    $convert.base64Decode(
        'Ch5CYXRjaFNldFBhcmFtZXRlclZhbHVlc1JlcXVlc3QSWgoIcmVxdWVzdHMYASADKAsyOS5ub3'
        'Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLlNldFBhcmFtZXRlclZhbHVlUmVxdWVzdEID'
        '4EECUghyZXF1ZXN0cw==');

@$core.Deprecated('Use batchSetParameterValuesResponseDescriptor instead')
const BatchSetParameterValuesResponse$json = {
  '1': 'BatchSetParameterValuesResponse',
  '2': [
    {
      '1': 'responses',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.SetParameterValueResponse',
      '10': 'responses'
    },
  ],
};

/// Descriptor for `BatchSetParameterValuesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchSetParameterValuesResponseDescriptor =
    $convert.base64Decode(
        'Ch9CYXRjaFNldFBhcmFtZXRlclZhbHVlc1Jlc3BvbnNlElgKCXJlc3BvbnNlcxgBIAMoCzI6Lm'
        '5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuU2V0UGFyYW1ldGVyVmFsdWVSZXNwb25z'
        'ZVIJcmVzcG9uc2Vz');

@$core.Deprecated('Use deviceSpecificCommandDescriptor instead')
const DeviceSpecificCommand$json = {
  '1': 'DeviceSpecificCommand',
  '2': [
    {'1': 'type', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'type'},
    {
      '1': 'parameter',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '8': {},
      '10': 'parameter'
    },
  ],
};

/// Descriptor for `DeviceSpecificCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceSpecificCommandDescriptor = $convert.base64Decode(
    'ChVEZXZpY2VTcGVjaWZpY0NvbW1hbmQSFwoEdHlwZRgCIAEoCUID4EECUgR0eXBlEjoKCXBhcm'
    'FtZXRlchgDIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RCA+BBAlIJcGFyYW1ldGVy');

@$core.Deprecated('Use executeDeviceSpecificCommandRequestDescriptor instead')
const ExecuteDeviceSpecificCommandRequest$json = {
  '1': 'ExecuteDeviceSpecificCommandRequest',
  '2': [
    {
      '1': 'device_instance_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'deviceInstanceId'
    },
    {
      '1': 'command',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceSpecificCommand',
      '8': {},
      '10': 'command'
    },
  ],
};

/// Descriptor for `ExecuteDeviceSpecificCommandRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeDeviceSpecificCommandRequestDescriptor =
    $convert.base64Decode(
        'CiNFeGVjdXRlRGV2aWNlU3BlY2lmaWNDb21tYW5kUmVxdWVzdBIxChJkZXZpY2VfaW5zdGFuY2'
        'VfaWQYASABKAlCA+BBAlIQZGV2aWNlSW5zdGFuY2VJZBJVCgdjb21tYW5kGAIgASgLMjYubm92'
        'b25vdGVzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5EZXZpY2VTcGVjaWZpY0NvbW1hbmRCA+BBAl'
        'IHY29tbWFuZA==');

@$core.Deprecated('Use executeDeviceSpecificCommandResponseDescriptor instead')
const ExecuteDeviceSpecificCommandResponse$json = {
  '1': 'ExecuteDeviceSpecificCommandResponse',
  '2': [
    {
      '1': 'command_result',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'commandResult'
    },
  ],
};

/// Descriptor for `ExecuteDeviceSpecificCommandResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeDeviceSpecificCommandResponseDescriptor =
    $convert.base64Decode(
        'CiRFeGVjdXRlRGV2aWNlU3BlY2lmaWNDb21tYW5kUmVzcG9uc2USPgoOY29tbWFuZF9yZXN1bH'
        'QYASABKAsyFy5nb29nbGUucHJvdG9idWYuU3RydWN0Ug1jb21tYW5kUmVzdWx0');

@$core.Deprecated('Use startParameterSyncRequestDescriptor instead')
const StartParameterSyncRequest$json = {
  '1': 'StartParameterSyncRequest',
  '2': [
    {'1': 'rt_session_id', '3': 1, '4': 1, '5': 5, '10': 'rtSessionId'},
    {
      '1': 'parameter_sync_keys',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'parameterSyncKeys'
    },
  ],
};

/// Descriptor for `StartParameterSyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startParameterSyncRequestDescriptor = $convert.base64Decode(
    'ChlTdGFydFBhcmFtZXRlclN5bmNSZXF1ZXN0EiIKDXJ0X3Nlc3Npb25faWQYASABKAVSC3J0U2'
    'Vzc2lvbklkEi4KE3BhcmFtZXRlcl9zeW5jX2tleXMYAiADKAlSEXBhcmFtZXRlclN5bmNLZXlz');

@$core.Deprecated('Use startParameterSyncResponseDescriptor instead')
const StartParameterSyncResponse$json = {
  '1': 'StartParameterSyncResponse',
};

/// Descriptor for `StartParameterSyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startParameterSyncResponseDescriptor =
    $convert.base64Decode('ChpTdGFydFBhcmFtZXRlclN5bmNSZXNwb25zZQ==');

@$core.Deprecated('Use stopParameterSyncRequestDescriptor instead')
const StopParameterSyncRequest$json = {
  '1': 'StopParameterSyncRequest',
  '2': [
    {'1': 'rt_session_id', '3': 1, '4': 1, '5': 5, '10': 'rtSessionId'},
    {
      '1': 'parameter_sync_keys',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'parameterSyncKeys'
    },
  ],
};

/// Descriptor for `StopParameterSyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopParameterSyncRequestDescriptor = $convert.base64Decode(
    'ChhTdG9wUGFyYW1ldGVyU3luY1JlcXVlc3QSIgoNcnRfc2Vzc2lvbl9pZBgBIAEoBVILcnRTZX'
    'NzaW9uSWQSLgoTcGFyYW1ldGVyX3N5bmNfa2V5cxgCIAMoCVIRcGFyYW1ldGVyU3luY0tleXM=');

@$core.Deprecated('Use stopParameterSyncResponseDescriptor instead')
const StopParameterSyncResponse$json = {
  '1': 'StopParameterSyncResponse',
};

/// Descriptor for `StopParameterSyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopParameterSyncResponseDescriptor =
    $convert.base64Decode('ChlTdG9wUGFyYW1ldGVyU3luY1Jlc3BvbnNl');

@$core.Deprecated('Use rtUpdateParameterCommandDescriptor instead')
const RtUpdateParameterCommand$json = {
  '1': 'RtUpdateParameterCommand',
  '2': [
    {
      '1': 'parameter_sync_key',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'parameterSyncKey'
    },
    {'1': 'text_value', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'textValue'},
    {
      '1': 'normalized_value',
      '3': 11,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'normalizedValue'
    },
  ],
  '8': [
    {'1': 'new_value'},
  ],
};

/// Descriptor for `RtUpdateParameterCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtUpdateParameterCommandDescriptor = $convert.base64Decode(
    'ChhSdFVwZGF0ZVBhcmFtZXRlckNvbW1hbmQSLAoScGFyYW1ldGVyX3N5bmNfa2V5GAEgASgJUh'
    'BwYXJhbWV0ZXJTeW5jS2V5Eh8KCnRleHRfdmFsdWUYCiABKAlIAFIJdGV4dFZhbHVlEisKEG5v'
    'cm1hbGl6ZWRfdmFsdWUYCyABKAFIAFIPbm9ybWFsaXplZFZhbHVlQgsKCW5ld192YWx1ZQ==');

@$core.Deprecated('Use rtFinalizeParameterCommandDescriptor instead')
const RtFinalizeParameterCommand$json = {
  '1': 'RtFinalizeParameterCommand',
  '2': [
    {
      '1': 'parameter_sync_key',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'parameterSyncKey'
    },
    {'1': 'text_value', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'textValue'},
    {
      '1': 'normalized_value',
      '3': 11,
      '4': 1,
      '5': 1,
      '9': 0,
      '10': 'normalizedValue'
    },
  ],
  '8': [
    {'1': 'new_value'},
  ],
};

/// Descriptor for `RtFinalizeParameterCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtFinalizeParameterCommandDescriptor = $convert.base64Decode(
    'ChpSdEZpbmFsaXplUGFyYW1ldGVyQ29tbWFuZBIsChJwYXJhbWV0ZXJfc3luY19rZXkYASABKA'
    'lSEHBhcmFtZXRlclN5bmNLZXkSHwoKdGV4dF92YWx1ZRgKIAEoCUgAUgl0ZXh0VmFsdWUSKwoQ'
    'bm9ybWFsaXplZF92YWx1ZRgLIAEoAUgAUg9ub3JtYWxpemVkVmFsdWVCCwoJbmV3X3ZhbHVl');

@$core.Deprecated('Use rtParameterDescriptor instead')
const RtParameter$json = {
  '1': 'RtParameter',
  '2': [
    {
      '1': 'parameter_sync_key',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'parameterSyncKey'
    },
    {'1': 'sequence_number', '3': 2, '4': 1, '5': 5, '10': 'sequenceNumber'},
    {
      '1': 'text_unmodulated_value',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'textUnmodulatedValue'
    },
    {
      '1': 'normalized_unmodulated_value',
      '3': 4,
      '4': 1,
      '5': 1,
      '10': 'normalizedUnmodulatedValue'
    },
    {
      '1': 'normalized_modulated_value',
      '3': 5,
      '4': 1,
      '5': 1,
      '10': 'normalizedModulatedValue'
    },
    {
      '1': 'state',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.novonotes.audio_engine.v1alpha1.RtParameter.State',
      '10': 'state'
    },
  ],
  '4': [RtParameter_State$json],
};

@$core.Deprecated('Use rtParameterDescriptor instead')
const RtParameter_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'STATE_FINALIZED', '2': 1},
    {'1': 'STATE_UPDATING', '2': 2},
  ],
};

/// Descriptor for `RtParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtParameterDescriptor = $convert.base64Decode(
    'CgtSdFBhcmFtZXRlchIsChJwYXJhbWV0ZXJfc3luY19rZXkYASABKAlSEHBhcmFtZXRlclN5bm'
    'NLZXkSJwoPc2VxdWVuY2VfbnVtYmVyGAIgASgFUg5zZXF1ZW5jZU51bWJlchI0ChZ0ZXh0X3Vu'
    'bW9kdWxhdGVkX3ZhbHVlGAMgASgJUhR0ZXh0VW5tb2R1bGF0ZWRWYWx1ZRJAChxub3JtYWxpem'
    'VkX3VubW9kdWxhdGVkX3ZhbHVlGAQgASgBUhpub3JtYWxpemVkVW5tb2R1bGF0ZWRWYWx1ZRI8'
    'Chpub3JtYWxpemVkX21vZHVsYXRlZF92YWx1ZRgFIAEoAVIYbm9ybWFsaXplZE1vZHVsYXRlZF'
    'ZhbHVlEkgKBXN0YXRlGAogASgOMjIubm92b25vdGVzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5S'
    'dFBhcmFtZXRlci5TdGF0ZVIFc3RhdGUiRwoFU3RhdGUSFQoRU1RBVEVfVU5TUEVDSUZJRUQQAB'
    'ITCg9TVEFURV9GSU5BTElaRUQQARISCg5TVEFURV9VUERBVElORxAC');
