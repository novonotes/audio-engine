//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/device_instance.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///
/// ```mermaid
/// stateDiagram-v2
/// [*] --> STATE_FINALIZED : Initial State
/// STATE_FINALIZED --> STATE_UPDATING : Update Command
/// STATE_UPDATING --> STATE_FINALIZED : Finalize Command
/// ```
class RtParameter_State extends $pb.ProtobufEnum {
  static const RtParameter_State STATE_UNSPECIFIED =
      RtParameter_State._(0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');

  /// 初期状態。
  static const RtParameter_State STATE_FINALIZED =
      RtParameter_State._(1, _omitEnumNames ? '' : 'STATE_FINALIZED');
  static const RtParameter_State STATE_UPDATING =
      RtParameter_State._(2, _omitEnumNames ? '' : 'STATE_UPDATING');

  static const $core.List<RtParameter_State> values = <RtParameter_State>[
    STATE_UNSPECIFIED,
    STATE_FINALIZED,
    STATE_UPDATING,
  ];

  static final $core.Map<$core.int, RtParameter_State> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static RtParameter_State? valueOf($core.int value) => _byValue[value];

  const RtParameter_State._(super.v, super.n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
