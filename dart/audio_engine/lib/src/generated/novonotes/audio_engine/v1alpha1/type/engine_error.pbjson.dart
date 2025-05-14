//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/type/engine_error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use engineErrorDescriptor instead')
const EngineError$json = {
  '1': 'EngineError',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'details',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.protobuf.Any',
      '10': 'details'
    },
  ],
};

/// Descriptor for `EngineError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List engineErrorDescriptor = $convert.base64Decode(
    'CgtFbmdpbmVFcnJvchISCgRjb2RlGAEgASgFUgRjb2RlEhgKB21lc3NhZ2UYAiABKAlSB21lc3'
    'NhZ2USLgoHZGV0YWlscxgDIAMoCzIULmdvb2dsZS5wcm90b2J1Zi5BbnlSB2RldGFpbHM=');
