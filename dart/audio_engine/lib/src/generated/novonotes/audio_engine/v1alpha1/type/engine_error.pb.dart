//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/type/engine_error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../../google/protobuf/any.pb.dart' as $6;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Represents an error in the audio engine.
/// This message is used to communicate error details to the peer application.
class EngineError extends $pb.GeneratedMessage {
  factory EngineError({
    $core.int? code,
    $core.String? message,
    $core.Iterable<$6.Any>? details,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (message != null) {
      $result.message = message;
    }
    if (details != null) {
      $result.details.addAll(details);
    }
    return $result;
  }
  EngineError._() : super();
  factory EngineError.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EngineError.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EngineError',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1.type'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<$6.Any>(3, _omitFieldNames ? '' : 'details', $pb.PbFieldType.PM,
        subBuilder: $6.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EngineError clone() => EngineError()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EngineError copyWith(void Function(EngineError) updates) =>
      super.copyWith((message) => updates(message as EngineError))
          as EngineError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EngineError create() => EngineError._();
  EngineError createEmptyInstance() => create();
  static $pb.PbList<EngineError> createRepeated() => $pb.PbList<EngineError>();
  @$core.pragma('dart2js:noInline')
  static EngineError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EngineError>(create);
  static EngineError? _defaultInstance;

  /// The status code, which should be an enum value of [google.rpc.Code][google.rpc.Code].
  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  /// A developer-facing error message, which should be in English. Any
  /// user-facing error message should be localized by the client.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  /// A list of messages that carry the error details.
  @$pb.TagNumber(3)
  $pb.PbList<$6.Any> get details => $_getList(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
