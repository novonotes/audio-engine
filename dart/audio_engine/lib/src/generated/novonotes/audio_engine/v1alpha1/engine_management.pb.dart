//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/engine_management.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InitializeRequest extends $pb.GeneratedMessage {
  factory InitializeRequest({
    $core.String? appInstanceId,
    $core.String? schemaVersion,
  }) {
    final $result = create();
    if (appInstanceId != null) {
      $result.appInstanceId = appInstanceId;
    }
    if (schemaVersion != null) {
      $result.schemaVersion = schemaVersion;
    }
    return $result;
  }
  InitializeRequest._() : super();
  factory InitializeRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InitializeRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitializeRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appInstanceId')
    ..aOS(2, _omitFieldNames ? '' : 'schemaVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  InitializeRequest clone() => InitializeRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  InitializeRequest copyWith(void Function(InitializeRequest) updates) =>
      super.copyWith((message) => updates(message as InitializeRequest))
          as InitializeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitializeRequest create() => InitializeRequest._();
  InitializeRequest createEmptyInstance() => create();
  static $pb.PbList<InitializeRequest> createRepeated() =>
      $pb.PbList<InitializeRequest>();
  @$core.pragma('dart2js:noInline')
  static InitializeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitializeRequest>(create);
  static InitializeRequest? _defaultInstance;

  /// Usually the pid of the application sending this request.
  @$pb.TagNumber(1)
  $core.String get appInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set appInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAppInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppInstanceId() => $_clearField(1);

  /// Should be "v1alpha1"
  @$pb.TagNumber(2)
  $core.String get schemaVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set schemaVersion($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSchemaVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearSchemaVersion() => $_clearField(2);
}

class InitializeResponse extends $pb.GeneratedMessage {
  factory InitializeResponse({
    $core.String? engineTypeId,
    $core.String? displayName,
    $core.String? schemaVersion,
    $core.int? pid,
  }) {
    final $result = create();
    if (engineTypeId != null) {
      $result.engineTypeId = engineTypeId;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (schemaVersion != null) {
      $result.schemaVersion = schemaVersion;
    }
    if (pid != null) {
      $result.pid = pid;
    }
    return $result;
  }
  InitializeResponse._() : super();
  factory InitializeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory InitializeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitializeResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(3, _omitFieldNames ? '' : 'engineTypeId')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(6, _omitFieldNames ? '' : 'schemaVersion')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'pid', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  InitializeResponse clone() => InitializeResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  InitializeResponse copyWith(void Function(InitializeResponse) updates) =>
      super.copyWith((message) => updates(message as InitializeResponse))
          as InitializeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitializeResponse create() => InitializeResponse._();
  InitializeResponse createEmptyInstance() => create();
  static $pb.PbList<InitializeResponse> createRepeated() =>
      $pb.PbList<InitializeResponse>();
  @$core.pragma('dart2js:noInline')
  static InitializeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitializeResponse>(create);
  static InitializeResponse? _defaultInstance;

  ///  Examples:
  ///
  ///  "novonotes.audio-engine-library.v1"
  ///  "novonotes.audio-engine-service.v2"
  ///  "novonotes.beatgen-plugin.v2",
  ///  "your-company.awesome-engine.v3"
  @$pb.TagNumber(3)
  $core.String get engineTypeId => $_getSZ(0);
  @$pb.TagNumber(3)
  set engineTypeId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEngineTypeId() => $_has(0);
  @$pb.TagNumber(3)
  void clearEngineTypeId() => $_clearField(3);

  ///  Examples:
  ///
  ///  "In-process Audio Engine"
  ///  "Out-process Audio Engine"
  ///  "My Super Audio Engine"
  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(4)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  /// Should be "v1alpha1"
  @$pb.TagNumber(6)
  $core.String get schemaVersion => $_getSZ(2);
  @$pb.TagNumber(6)
  set schemaVersion($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSchemaVersion() => $_has(2);
  @$pb.TagNumber(6)
  void clearSchemaVersion() => $_clearField(6);

  /// Pid of the engine.
  @$pb.TagNumber(7)
  $core.int get pid => $_getIZ(3);
  @$pb.TagNumber(7)
  set pid($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPid() => $_has(3);
  @$pb.TagNumber(7)
  void clearPid() => $_clearField(7);
}

class ShutdownRequest extends $pb.GeneratedMessage {
  factory ShutdownRequest() => create();
  ShutdownRequest._() : super();
  factory ShutdownRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ShutdownRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ShutdownRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ShutdownRequest clone() => ShutdownRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ShutdownRequest copyWith(void Function(ShutdownRequest) updates) =>
      super.copyWith((message) => updates(message as ShutdownRequest))
          as ShutdownRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShutdownRequest create() => ShutdownRequest._();
  ShutdownRequest createEmptyInstance() => create();
  static $pb.PbList<ShutdownRequest> createRepeated() =>
      $pb.PbList<ShutdownRequest>();
  @$core.pragma('dart2js:noInline')
  static ShutdownRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ShutdownRequest>(create);
  static ShutdownRequest? _defaultInstance;
}

class ShutdownResponse extends $pb.GeneratedMessage {
  factory ShutdownResponse() => create();
  ShutdownResponse._() : super();
  factory ShutdownResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ShutdownResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ShutdownResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ShutdownResponse clone() => ShutdownResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ShutdownResponse copyWith(void Function(ShutdownResponse) updates) =>
      super.copyWith((message) => updates(message as ShutdownResponse))
          as ShutdownResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShutdownResponse create() => ShutdownResponse._();
  ShutdownResponse createEmptyInstance() => create();
  static $pb.PbList<ShutdownResponse> createRepeated() =>
      $pb.PbList<ShutdownResponse>();
  @$core.pragma('dart2js:noInline')
  static ShutdownResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ShutdownResponse>(create);
  static ShutdownResponse? _defaultInstance;
}

///  Resets the engine state to the initial state.
///
///  Only the editing state is reset.
///  The configuration is not reset. (e.g. the output device)
class ResetStateRequest extends $pb.GeneratedMessage {
  factory ResetStateRequest() => create();
  ResetStateRequest._() : super();
  factory ResetStateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResetStateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetStateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResetStateRequest clone() => ResetStateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResetStateRequest copyWith(void Function(ResetStateRequest) updates) =>
      super.copyWith((message) => updates(message as ResetStateRequest))
          as ResetStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetStateRequest create() => ResetStateRequest._();
  ResetStateRequest createEmptyInstance() => create();
  static $pb.PbList<ResetStateRequest> createRepeated() =>
      $pb.PbList<ResetStateRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetStateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetStateRequest>(create);
  static ResetStateRequest? _defaultInstance;
}

class ResetStateResponse extends $pb.GeneratedMessage {
  factory ResetStateResponse() => create();
  ResetStateResponse._() : super();
  factory ResetStateResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResetStateResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetStateResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ResetStateResponse clone() => ResetStateResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ResetStateResponse copyWith(void Function(ResetStateResponse) updates) =>
      super.copyWith((message) => updates(message as ResetStateResponse))
          as ResetStateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetStateResponse create() => ResetStateResponse._();
  ResetStateResponse createEmptyInstance() => create();
  static $pb.PbList<ResetStateResponse> createRepeated() =>
      $pb.PbList<ResetStateResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetStateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetStateResponse>(create);
  static ResetStateResponse? _defaultInstance;
}

class PlayTestToneRequest extends $pb.GeneratedMessage {
  factory PlayTestToneRequest() => create();
  PlayTestToneRequest._() : super();
  factory PlayTestToneRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlayTestToneRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayTestToneRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlayTestToneRequest clone() => PlayTestToneRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlayTestToneRequest copyWith(void Function(PlayTestToneRequest) updates) =>
      super.copyWith((message) => updates(message as PlayTestToneRequest))
          as PlayTestToneRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayTestToneRequest create() => PlayTestToneRequest._();
  PlayTestToneRequest createEmptyInstance() => create();
  static $pb.PbList<PlayTestToneRequest> createRepeated() =>
      $pb.PbList<PlayTestToneRequest>();
  @$core.pragma('dart2js:noInline')
  static PlayTestToneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayTestToneRequest>(create);
  static PlayTestToneRequest? _defaultInstance;
}

class PlayTestToneResponse extends $pb.GeneratedMessage {
  factory PlayTestToneResponse() => create();
  PlayTestToneResponse._() : super();
  factory PlayTestToneResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlayTestToneResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayTestToneResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlayTestToneResponse clone() =>
      PlayTestToneResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlayTestToneResponse copyWith(void Function(PlayTestToneResponse) updates) =>
      super.copyWith((message) => updates(message as PlayTestToneResponse))
          as PlayTestToneResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayTestToneResponse create() => PlayTestToneResponse._();
  PlayTestToneResponse createEmptyInstance() => create();
  static $pb.PbList<PlayTestToneResponse> createRepeated() =>
      $pb.PbList<PlayTestToneResponse>();
  @$core.pragma('dart2js:noInline')
  static PlayTestToneResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayTestToneResponse>(create);
  static PlayTestToneResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
