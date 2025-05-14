//
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use bodyTypeDescriptor instead')
const BodyType$json = {
  '1': 'BodyType',
  '2': [
    {'1': 'HANDSHAKE', '2': 0},
    {'1': 'HELLO_REQUEST', '2': 1},
    {'1': 'HELLO_REPLY', '2': 2},
  ],
};

/// Descriptor for `BodyType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List bodyTypeDescriptor = $convert.base64Decode(
    'CghCb2R5VHlwZRINCglIQU5EU0hBS0UQABIRCg1IRUxMT19SRVFVRVNUEAESDwoLSEVMTE9fUk'
    'VQTFkQAg==');

@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = {
  '1': 'HelloRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor =
    $convert.base64Decode('CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');

@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = {
  '1': 'HelloReply',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert
    .base64Decode('CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use contextDescriptor instead')
const Context$json = {
  '1': 'Context',
};

/// Descriptor for `Context`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contextDescriptor =
    $convert.base64Decode('CgdDb250ZXh0');
