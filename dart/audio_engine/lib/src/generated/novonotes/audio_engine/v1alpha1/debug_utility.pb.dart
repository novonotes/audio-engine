//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/debug_utility.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DebugStateRequest extends $pb.GeneratedMessage {
  factory DebugStateRequest() => create();
  DebugStateRequest._() : super();
  factory DebugStateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugStateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebugStateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DebugStateRequest clone() => DebugStateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DebugStateRequest copyWith(void Function(DebugStateRequest) updates) =>
      super.copyWith((message) => updates(message as DebugStateRequest))
          as DebugStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugStateRequest create() => DebugStateRequest._();
  DebugStateRequest createEmptyInstance() => create();
  static $pb.PbList<DebugStateRequest> createRepeated() =>
      $pb.PbList<DebugStateRequest>();
  @$core.pragma('dart2js:noInline')
  static DebugStateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebugStateRequest>(create);
  static DebugStateRequest? _defaultInstance;
}

class DebugStateResponse extends $pb.GeneratedMessage {
  factory DebugStateResponse({
    $core.String? state,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  DebugStateResponse._() : super();
  factory DebugStateResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugStateResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebugStateResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'state')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DebugStateResponse clone() => DebugStateResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DebugStateResponse copyWith(void Function(DebugStateResponse) updates) =>
      super.copyWith((message) => updates(message as DebugStateResponse))
          as DebugStateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugStateResponse create() => DebugStateResponse._();
  DebugStateResponse createEmptyInstance() => create();
  static $pb.PbList<DebugStateResponse> createRepeated() =>
      $pb.PbList<DebugStateResponse>();
  @$core.pragma('dart2js:noInline')
  static DebugStateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebugStateResponse>(create);
  static DebugStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get state => $_getSZ(0);
  @$pb.TagNumber(1)
  set state($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
}

class SaveStateRequest extends $pb.GeneratedMessage {
  factory SaveStateRequest({
    $core.String? destFilePath,
  }) {
    final $result = create();
    if (destFilePath != null) {
      $result.destFilePath = destFilePath;
    }
    return $result;
  }
  SaveStateRequest._() : super();
  factory SaveStateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SaveStateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveStateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destFilePath')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SaveStateRequest clone() => SaveStateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SaveStateRequest copyWith(void Function(SaveStateRequest) updates) =>
      super.copyWith((message) => updates(message as SaveStateRequest))
          as SaveStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveStateRequest create() => SaveStateRequest._();
  SaveStateRequest createEmptyInstance() => create();
  static $pb.PbList<SaveStateRequest> createRepeated() =>
      $pb.PbList<SaveStateRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveStateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveStateRequest>(create);
  static SaveStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destFilePath => $_getSZ(0);
  @$pb.TagNumber(1)
  set destFilePath($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDestFilePath() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestFilePath() => $_clearField(1);
}

class SaveStateResponse extends $pb.GeneratedMessage {
  factory SaveStateResponse() => create();
  SaveStateResponse._() : super();
  factory SaveStateResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SaveStateResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveStateResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SaveStateResponse clone() => SaveStateResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SaveStateResponse copyWith(void Function(SaveStateResponse) updates) =>
      super.copyWith((message) => updates(message as SaveStateResponse))
          as SaveStateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveStateResponse create() => SaveStateResponse._();
  SaveStateResponse createEmptyInstance() => create();
  static $pb.PbList<SaveStateResponse> createRepeated() =>
      $pb.PbList<SaveStateResponse>();
  @$core.pragma('dart2js:noInline')
  static SaveStateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveStateResponse>(create);
  static SaveStateResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
