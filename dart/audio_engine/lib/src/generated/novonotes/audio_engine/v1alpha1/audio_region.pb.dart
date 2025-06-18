//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/audio_region.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 音声データの特定の範囲を表すオブジェクト。
/// トラック上に配置され、開始位置や長さ、ゲイン、フェードイン/フェードアウトなどの情報を持つ。
class AudioRegion extends $pb.GeneratedMessage {
  factory AudioRegion({
    $core.String? id,
    $core.String? parentId,
    $core.String? sourceFilePath,
    $core.double? position,
    $core.double? duration,
    $core.double? gainDb,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (parentId != null) {
      $result.parentId = parentId;
    }
    if (sourceFilePath != null) {
      $result.sourceFilePath = sourceFilePath;
    }
    if (position != null) {
      $result.position = position;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (gainDb != null) {
      $result.gainDb = gainDb;
    }
    return $result;
  }
  AudioRegion._() : super();
  factory AudioRegion.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AudioRegion.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioRegion',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'parentId')
    ..aOS(3, _omitFieldNames ? '' : 'sourceFilePath')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'position', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'duration', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'gainDb', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AudioRegion clone() => AudioRegion()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AudioRegion copyWith(void Function(AudioRegion) updates) =>
      super.copyWith((message) => updates(message as AudioRegion))
          as AudioRegion;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioRegion create() => AudioRegion._();
  AudioRegion createEmptyInstance() => create();
  static $pb.PbList<AudioRegion> createRepeated() => $pb.PbList<AudioRegion>();
  @$core.pragma('dart2js:noInline')
  static AudioRegion getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioRegion>(create);
  static AudioRegion? _defaultInstance;

  /// ユーザー指定の id
  /// id は全リソースがユニークな値を持つように指定する必要がある。
  /// 重複時は、ALREADY_EXISTS のエラー。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get parentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set parentId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParentId() => $_clearField(2);

  /// Must be absolute path
  @$pb.TagNumber(3)
  $core.String get sourceFilePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceFilePath($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSourceFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceFilePath() => $_clearField(3);

  /// Position in quarter note
  @$pb.TagNumber(4)
  $core.double get position => $_getN(3);
  @$pb.TagNumber(4)
  set position($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearPosition() => $_clearField(4);

  ///  Duration in quarter note
  /// / null の場合は Source File の長さと同じ長さの AudioRegion を作成
  @$pb.TagNumber(5)
  $core.double get duration => $_getN(4);
  @$pb.TagNumber(5)
  set duration($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => $_clearField(5);

  /// Gain in decibel
  @$pb.TagNumber(6)
  $core.double get gainDb => $_getN(5);
  @$pb.TagNumber(6)
  set gainDb($core.double v) {
    $_setDouble(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasGainDb() => $_has(5);
  @$pb.TagNumber(6)
  void clearGainDb() => $_clearField(6);
}

class CreateAudioRegionRequest extends $pb.GeneratedMessage {
  factory CreateAudioRegionRequest({
    $core.String? parentId,
    AudioRegion? audioRegion,
  }) {
    final $result = create();
    if (parentId != null) {
      $result.parentId = parentId;
    }
    if (audioRegion != null) {
      $result.audioRegion = audioRegion;
    }
    return $result;
  }
  CreateAudioRegionRequest._() : super();
  factory CreateAudioRegionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAudioRegionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAudioRegionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'parentId')
    ..aOM<AudioRegion>(3, _omitFieldNames ? '' : 'audioRegion',
        subBuilder: AudioRegion.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAudioRegionRequest clone() =>
      CreateAudioRegionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAudioRegionRequest copyWith(
          void Function(CreateAudioRegionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateAudioRegionRequest))
          as CreateAudioRegionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAudioRegionRequest create() => CreateAudioRegionRequest._();
  CreateAudioRegionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAudioRegionRequest> createRepeated() =>
      $pb.PbList<CreateAudioRegionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAudioRegionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAudioRegionRequest>(create);
  static CreateAudioRegionRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get parentId => $_getSZ(0);
  @$pb.TagNumber(2)
  set parentId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasParentId() => $_has(0);
  @$pb.TagNumber(2)
  void clearParentId() => $_clearField(2);

  @$pb.TagNumber(3)
  AudioRegion get audioRegion => $_getN(1);
  @$pb.TagNumber(3)
  set audioRegion(AudioRegion v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAudioRegion() => $_has(1);
  @$pb.TagNumber(3)
  void clearAudioRegion() => $_clearField(3);
  @$pb.TagNumber(3)
  AudioRegion ensureAudioRegion() => $_ensure(1);
}

class CreateAudioRegionResponse extends $pb.GeneratedMessage {
  factory CreateAudioRegionResponse() => create();
  CreateAudioRegionResponse._() : super();
  factory CreateAudioRegionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAudioRegionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAudioRegionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAudioRegionResponse clone() =>
      CreateAudioRegionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAudioRegionResponse copyWith(
          void Function(CreateAudioRegionResponse) updates) =>
      super.copyWith((message) => updates(message as CreateAudioRegionResponse))
          as CreateAudioRegionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAudioRegionResponse create() => CreateAudioRegionResponse._();
  CreateAudioRegionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateAudioRegionResponse> createRepeated() =>
      $pb.PbList<CreateAudioRegionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateAudioRegionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAudioRegionResponse>(create);
  static CreateAudioRegionResponse? _defaultInstance;
}

class UpdateAudioRegionRequest extends $pb.GeneratedMessage {
  factory UpdateAudioRegionRequest({
    AudioRegion? audioRegion,
  }) {
    final $result = create();
    if (audioRegion != null) {
      $result.audioRegion = audioRegion;
    }
    return $result;
  }
  UpdateAudioRegionRequest._() : super();
  factory UpdateAudioRegionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateAudioRegionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAudioRegionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<AudioRegion>(1, _omitFieldNames ? '' : 'audioRegion',
        subBuilder: AudioRegion.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateAudioRegionRequest clone() =>
      UpdateAudioRegionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateAudioRegionRequest copyWith(
          void Function(UpdateAudioRegionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateAudioRegionRequest))
          as UpdateAudioRegionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAudioRegionRequest create() => UpdateAudioRegionRequest._();
  UpdateAudioRegionRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAudioRegionRequest> createRepeated() =>
      $pb.PbList<UpdateAudioRegionRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAudioRegionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAudioRegionRequest>(create);
  static UpdateAudioRegionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  AudioRegion get audioRegion => $_getN(0);
  @$pb.TagNumber(1)
  set audioRegion(AudioRegion v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAudioRegion() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioRegion() => $_clearField(1);
  @$pb.TagNumber(1)
  AudioRegion ensureAudioRegion() => $_ensure(0);
}

class UpdateAudioRegionResponse extends $pb.GeneratedMessage {
  factory UpdateAudioRegionResponse() => create();
  UpdateAudioRegionResponse._() : super();
  factory UpdateAudioRegionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateAudioRegionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAudioRegionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateAudioRegionResponse clone() =>
      UpdateAudioRegionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateAudioRegionResponse copyWith(
          void Function(UpdateAudioRegionResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateAudioRegionResponse))
          as UpdateAudioRegionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAudioRegionResponse create() => UpdateAudioRegionResponse._();
  UpdateAudioRegionResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateAudioRegionResponse> createRepeated() =>
      $pb.PbList<UpdateAudioRegionResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateAudioRegionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAudioRegionResponse>(create);
  static UpdateAudioRegionResponse? _defaultInstance;
}

class DeleteAudioRegionRequest extends $pb.GeneratedMessage {
  factory DeleteAudioRegionRequest({
    $core.String? audioRegionId,
  }) {
    final $result = create();
    if (audioRegionId != null) {
      $result.audioRegionId = audioRegionId;
    }
    return $result;
  }
  DeleteAudioRegionRequest._() : super();
  factory DeleteAudioRegionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteAudioRegionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAudioRegionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioRegionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteAudioRegionRequest clone() =>
      DeleteAudioRegionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteAudioRegionRequest copyWith(
          void Function(DeleteAudioRegionRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteAudioRegionRequest))
          as DeleteAudioRegionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAudioRegionRequest create() => DeleteAudioRegionRequest._();
  DeleteAudioRegionRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAudioRegionRequest> createRepeated() =>
      $pb.PbList<DeleteAudioRegionRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAudioRegionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAudioRegionRequest>(create);
  static DeleteAudioRegionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioRegionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioRegionId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAudioRegionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioRegionId() => $_clearField(1);
}

class DeleteAudioRegionResponse extends $pb.GeneratedMessage {
  factory DeleteAudioRegionResponse() => create();
  DeleteAudioRegionResponse._() : super();
  factory DeleteAudioRegionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteAudioRegionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAudioRegionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteAudioRegionResponse clone() =>
      DeleteAudioRegionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteAudioRegionResponse copyWith(
          void Function(DeleteAudioRegionResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteAudioRegionResponse))
          as DeleteAudioRegionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAudioRegionResponse create() => DeleteAudioRegionResponse._();
  DeleteAudioRegionResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAudioRegionResponse> createRepeated() =>
      $pb.PbList<DeleteAudioRegionResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAudioRegionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAudioRegionResponse>(create);
  static DeleteAudioRegionResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
