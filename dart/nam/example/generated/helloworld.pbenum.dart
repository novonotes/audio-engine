//
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class BodyType extends $pb.ProtobufEnum {
  static const BodyType HANDSHAKE =
      BodyType._(0, _omitEnumNames ? '' : 'HANDSHAKE');
  static const BodyType HELLO_REQUEST =
      BodyType._(1, _omitEnumNames ? '' : 'HELLO_REQUEST');
  static const BodyType HELLO_REPLY =
      BodyType._(2, _omitEnumNames ? '' : 'HELLO_REPLY');

  static const $core.List<BodyType> values = <BodyType>[
    HANDSHAKE,
    HELLO_REQUEST,
    HELLO_REPLY,
  ];

  static final $core.Map<$core.int, BodyType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static BodyType? valueOf($core.int value) => _byValue[value];

  const BodyType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
