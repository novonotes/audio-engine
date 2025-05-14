//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/rt_session.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use startRtSessionRequestDescriptor instead')
const StartRtSessionRequest$json = {
  '1': 'StartRtSessionRequest',
  '2': [
    {
      '1': 'state_receiver_uri',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'stateReceiverUri'
    },
    {'1': 'rt_session_id', '3': 2, '4': 1, '5': 5, '10': 'rtSessionId'},
  ],
};

/// Descriptor for `StartRtSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startRtSessionRequestDescriptor = $convert.base64Decode(
    'ChVTdGFydFJ0U2Vzc2lvblJlcXVlc3QSLAoSc3RhdGVfcmVjZWl2ZXJfdXJpGAEgASgJUhBzdG'
    'F0ZVJlY2VpdmVyVXJpEiIKDXJ0X3Nlc3Npb25faWQYAiABKAVSC3J0U2Vzc2lvbklk');

@$core.Deprecated('Use startRtSessionResponseDescriptor instead')
const StartRtSessionResponse$json = {
  '1': 'StartRtSessionResponse',
  '2': [
    {
      '1': 'command_receiver_uri',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'commandReceiverUri'
    },
  ],
};

/// Descriptor for `StartRtSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startRtSessionResponseDescriptor =
    $convert.base64Decode(
        'ChZTdGFydFJ0U2Vzc2lvblJlc3BvbnNlEjAKFGNvbW1hbmRfcmVjZWl2ZXJfdXJpGAEgASgJUh'
        'Jjb21tYW5kUmVjZWl2ZXJVcmk=');

@$core.Deprecated('Use stopRtSessionRequestDescriptor instead')
const StopRtSessionRequest$json = {
  '1': 'StopRtSessionRequest',
  '2': [
    {'1': 'rt_session_id', '3': 3, '4': 1, '5': 5, '10': 'rtSessionId'},
  ],
};

/// Descriptor for `StopRtSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopRtSessionRequestDescriptor = $convert.base64Decode(
    'ChRTdG9wUnRTZXNzaW9uUmVxdWVzdBIiCg1ydF9zZXNzaW9uX2lkGAMgASgFUgtydFNlc3Npb2'
    '5JZA==');

@$core.Deprecated('Use stopRtSessionResponseDescriptor instead')
const StopRtSessionResponse$json = {
  '1': 'StopRtSessionResponse',
};

/// Descriptor for `StopRtSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopRtSessionResponseDescriptor =
    $convert.base64Decode('ChVTdG9wUnRTZXNzaW9uUmVzcG9uc2U=');

@$core.Deprecated('Use rtCommandBatchDescriptor instead')
const RtCommandBatch$json = {
  '1': 'RtCommandBatch',
  '2': [
    {
      '1': 'commands',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtCommandBatch.Command',
      '10': 'commands'
    },
  ],
  '3': [RtCommandBatch_Command$json],
};

@$core.Deprecated('Use rtCommandBatchDescriptor instead')
const RtCommandBatch_Command$json = {
  '1': 'Command',
  '2': [
    {
      '1': 'update_parameter',
      '3': 100,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtUpdateParameterCommand',
      '9': 0,
      '10': 'updateParameter'
    },
    {
      '1': 'finalize_parameter',
      '3': 101,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtFinalizeParameterCommand',
      '9': 0,
      '10': 'finalizeParameter'
    },
  ],
  '8': [
    {'1': 'type'},
  ],
};

/// Descriptor for `RtCommandBatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtCommandBatchDescriptor = $convert.base64Decode(
    'Cg5SdENvbW1hbmRCYXRjaBJTCghjb21tYW5kcxgBIAMoCzI3Lm5vdm9ub3Rlcy5hdWRpb19lbm'
    'dpbmUudjFhbHBoYTEuUnRDb21tYW5kQmF0Y2guQ29tbWFuZFIIY29tbWFuZHMa5wEKB0NvbW1h'
    'bmQSZgoQdXBkYXRlX3BhcmFtZXRlchhkIAEoCzI5Lm5vdm9ub3Rlcy5hdWRpb19lbmdpbmUudj'
    'FhbHBoYTEuUnRVcGRhdGVQYXJhbWV0ZXJDb21tYW5kSABSD3VwZGF0ZVBhcmFtZXRlchJsChJm'
    'aW5hbGl6ZV9wYXJhbWV0ZXIYZSABKAsyOy5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaG'
    'ExLlJ0RmluYWxpemVQYXJhbWV0ZXJDb21tYW5kSABSEWZpbmFsaXplUGFyYW1ldGVyQgYKBHR5'
    'cGU=');

@$core.Deprecated('Use rtStateFragmentDescriptor instead')
const RtStateFragment$json = {
  '1': 'RtStateFragment',
  '2': [
    {
      '1': 'entity_subset',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtStateFragment.EngineEntity',
      '10': 'entitySubset'
    },
  ],
  '3': [RtStateFragment_EngineEntity$json],
};

@$core.Deprecated('Use rtStateFragmentDescriptor instead')
const RtStateFragment_EngineEntity$json = {
  '1': 'EngineEntity',
  '2': [
    {
      '1': 'parameter',
      '3': 100,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtParameter',
      '9': 0,
      '10': 'parameter'
    },
    {
      '1': 'playhead',
      '3': 101,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.RtPlayheadPosition',
      '9': 0,
      '10': 'playhead'
    },
  ],
  '8': [
    {'1': 'type'},
  ],
};

/// Descriptor for `RtStateFragment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtStateFragmentDescriptor = $convert.base64Decode(
    'Cg9SdFN0YXRlRnJhZ21lbnQSYgoNZW50aXR5X3N1YnNldBgBIAMoCzI9Lm5vdm9ub3Rlcy5hdW'
    'Rpb19lbmdpbmUudjFhbHBoYTEuUnRTdGF0ZUZyYWdtZW50LkVuZ2luZUVudGl0eVIMZW50aXR5'
    'U3Vic2V0GrcBCgxFbmdpbmVFbnRpdHkSTAoJcGFyYW1ldGVyGGQgASgLMiwubm92b25vdGVzLm'
    'F1ZGlvX2VuZ2luZS52MWFscGhhMS5SdFBhcmFtZXRlckgAUglwYXJhbWV0ZXISUQoIcGxheWhl'
    'YWQYZSABKAsyMy5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLlJ0UGxheWhlYWRQb3'
    'NpdGlvbkgAUghwbGF5aGVhZEIGCgR0eXBl');
