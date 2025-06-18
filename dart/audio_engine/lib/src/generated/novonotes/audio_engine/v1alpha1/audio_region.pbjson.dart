//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/audio_region.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use audioRegionDescriptor instead')
const AudioRegion$json = {
  '1': 'AudioRegion',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'parent_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'parentId'},
    {
      '1': 'source_file_path',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'sourceFilePath'
    },
    {'1': 'position', '3': 4, '4': 1, '5': 1, '8': {}, '10': 'position'},
    {
      '1': 'duration',
      '3': 5,
      '4': 1,
      '5': 1,
      '8': {},
      '9': 0,
      '10': 'duration',
      '17': true
    },
    {'1': 'gain_db', '3': 6, '4': 1, '5': 1, '8': {}, '10': 'gainDb'},
  ],
  '7': {},
  '8': [
    {'1': '_duration'},
  ],
};

/// Descriptor for `AudioRegion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioRegionDescriptor = $convert.base64Decode(
    'CgtBdWRpb1JlZ2lvbhIWCgJpZBgBIAEoCUIG4EEI4EECUgJpZBJKCglwYXJlbnRfaWQYAiABKA'
    'lCLeBBA/pBJwolbm92b25vdGVzL2F1ZGlvLWVuZ2luZS1hcGkvQXVkaW9UcmFja1IIcGFyZW50'
    'SWQSLQoQc291cmNlX2ZpbGVfcGF0aBgDIAEoCUID4EECUg5zb3VyY2VGaWxlUGF0aBIfCghwb3'
    'NpdGlvbhgEIAEoAUID4EEBUghwb3NpdGlvbhIkCghkdXJhdGlvbhgFIAEoAUID4EEBSABSCGR1'
    'cmF0aW9uiAEBEhwKB2dhaW5fZGIYBiABKAFCA+BBAVIGZ2FpbkRiOkXqQUIKJW5vdm9ub3Rlcy'
    '9hdWRpby1lbmdpbi1hcGkvQXVkaW9SZWdpb24qDGF1ZGlvUmVnaW9uczILYXVkaW9SZWdpb25C'
    'CwoJX2R1cmF0aW9u');

@$core.Deprecated('Use createAudioRegionRequestDescriptor instead')
const CreateAudioRegionRequest$json = {
  '1': 'CreateAudioRegionRequest',
  '2': [
    {'1': 'parent_id', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'parentId'},
    {
      '1': 'audio_region',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.AudioRegion',
      '8': {},
      '10': 'audioRegion'
    },
  ],
};

/// Descriptor for `CreateAudioRegionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAudioRegionRequestDescriptor = $convert.base64Decode(
    'ChhDcmVhdGVBdWRpb1JlZ2lvblJlcXVlc3QSSgoJcGFyZW50X2lkGAIgASgJQi3gQQL6QScKJW'
    '5vdm9ub3Rlcy9hdWRpby1lbmdpbmUtYXBpL0F1ZGlvVHJhY2tSCHBhcmVudElkElQKDGF1ZGlv'
    'X3JlZ2lvbhgDIAEoCzIsLm5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudjFhbHBoYTEuQXVkaW9SZW'
    'dpb25CA+BBAlILYXVkaW9SZWdpb24=');

@$core.Deprecated('Use createAudioRegionResponseDescriptor instead')
const CreateAudioRegionResponse$json = {
  '1': 'CreateAudioRegionResponse',
};

/// Descriptor for `CreateAudioRegionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createAudioRegionResponseDescriptor =
    $convert.base64Decode('ChlDcmVhdGVBdWRpb1JlZ2lvblJlc3BvbnNl');

@$core.Deprecated('Use updateAudioRegionRequestDescriptor instead')
const UpdateAudioRegionRequest$json = {
  '1': 'UpdateAudioRegionRequest',
  '2': [
    {
      '1': 'audio_region',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.AudioRegion',
      '8': {},
      '10': 'audioRegion'
    },
  ],
};

/// Descriptor for `UpdateAudioRegionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAudioRegionRequestDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVBdWRpb1JlZ2lvblJlcXVlc3QSVAoMYXVkaW9fcmVnaW9uGAEgASgLMiwubm92b2'
    '5vdGVzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5BdWRpb1JlZ2lvbkID4EECUgthdWRpb1JlZ2lv'
    'bg==');

@$core.Deprecated('Use updateAudioRegionResponseDescriptor instead')
const UpdateAudioRegionResponse$json = {
  '1': 'UpdateAudioRegionResponse',
};

/// Descriptor for `UpdateAudioRegionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAudioRegionResponseDescriptor =
    $convert.base64Decode('ChlVcGRhdGVBdWRpb1JlZ2lvblJlc3BvbnNl');

@$core.Deprecated('Use deleteAudioRegionRequestDescriptor instead')
const DeleteAudioRegionRequest$json = {
  '1': 'DeleteAudioRegionRequest',
  '2': [
    {
      '1': 'audio_region_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {},
      '10': 'audioRegionId'
    },
  ],
};

/// Descriptor for `DeleteAudioRegionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAudioRegionRequestDescriptor =
    $convert.base64Decode(
        'ChhEZWxldGVBdWRpb1JlZ2lvblJlcXVlc3QSKwoPYXVkaW9fcmVnaW9uX2lkGAEgASgJQgPgQQ'
        'JSDWF1ZGlvUmVnaW9uSWQ=');

@$core.Deprecated('Use deleteAudioRegionResponseDescriptor instead')
const DeleteAudioRegionResponse$json = {
  '1': 'DeleteAudioRegionResponse',
};

/// Descriptor for `DeleteAudioRegionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAudioRegionResponseDescriptor =
    $convert.base64Decode('ChlEZWxldGVBdWRpb1JlZ2lvblJlc3BvbnNl');
