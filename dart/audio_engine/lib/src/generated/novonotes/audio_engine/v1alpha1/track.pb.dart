//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/track.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'track.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'track.pbenum.dart';

/// オーディオリージョンを配置するタイムライン。
class Track extends $pb.GeneratedMessage {
  factory Track({
    $core.String? id,
    Track_TrackType? type,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  Track._() : super();
  factory Track.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Track.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Track',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..e<Track_TrackType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: Track_TrackType.TRACK_TYPE_UNSPECIFIED,
        valueOf: Track_TrackType.valueOf,
        enumValues: Track_TrackType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Track clone() => Track()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Track copyWith(void Function(Track) updates) =>
      super.copyWith((message) => updates(message as Track)) as Track;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Track create() => Track._();
  Track createEmptyInstance() => create();
  static $pb.PbList<Track> createRepeated() => $pb.PbList<Track>();
  @$core.pragma('dart2js:noInline')
  static Track getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Track>(create);
  static Track? _defaultInstance;

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
  Track_TrackType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Track_TrackType v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);
}

class CreateTrackRequest extends $pb.GeneratedMessage {
  factory CreateTrackRequest({
    Track? track,
  }) {
    final $result = create();
    if (track != null) {
      $result.track = track;
    }
    return $result;
  }
  CreateTrackRequest._() : super();
  factory CreateTrackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTrackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTrackRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Track>(1, _omitFieldNames ? '' : 'track', subBuilder: Track.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTrackRequest clone() => CreateTrackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTrackRequest copyWith(void Function(CreateTrackRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTrackRequest))
          as CreateTrackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTrackRequest create() => CreateTrackRequest._();
  CreateTrackRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTrackRequest> createRepeated() =>
      $pb.PbList<CreateTrackRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTrackRequest>(create);
  static CreateTrackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Track get track => $_getN(0);
  @$pb.TagNumber(1)
  set track(Track v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  Track ensureTrack() => $_ensure(0);
}

class CreateTrackResponse extends $pb.GeneratedMessage {
  factory CreateTrackResponse() => create();
  CreateTrackResponse._() : super();
  factory CreateTrackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateTrackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTrackResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateTrackResponse clone() => CreateTrackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateTrackResponse copyWith(void Function(CreateTrackResponse) updates) =>
      super.copyWith((message) => updates(message as CreateTrackResponse))
          as CreateTrackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTrackResponse create() => CreateTrackResponse._();
  CreateTrackResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTrackResponse> createRepeated() =>
      $pb.PbList<CreateTrackResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTrackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTrackResponse>(create);
  static CreateTrackResponse? _defaultInstance;
}

class UpdateTrackRequest extends $pb.GeneratedMessage {
  factory UpdateTrackRequest({
    Track? track,
  }) {
    final $result = create();
    if (track != null) {
      $result.track = track;
    }
    return $result;
  }
  UpdateTrackRequest._() : super();
  factory UpdateTrackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateTrackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTrackRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Track>(1, _omitFieldNames ? '' : 'track', subBuilder: Track.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateTrackRequest clone() => UpdateTrackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateTrackRequest copyWith(void Function(UpdateTrackRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTrackRequest))
          as UpdateTrackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTrackRequest create() => UpdateTrackRequest._();
  UpdateTrackRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTrackRequest> createRepeated() =>
      $pb.PbList<UpdateTrackRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTrackRequest>(create);
  static UpdateTrackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Track get track => $_getN(0);
  @$pb.TagNumber(1)
  set track(Track v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  Track ensureTrack() => $_ensure(0);
}

class UpdateTrackResponse extends $pb.GeneratedMessage {
  factory UpdateTrackResponse() => create();
  UpdateTrackResponse._() : super();
  factory UpdateTrackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateTrackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTrackResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateTrackResponse clone() => UpdateTrackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateTrackResponse copyWith(void Function(UpdateTrackResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateTrackResponse))
          as UpdateTrackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTrackResponse create() => UpdateTrackResponse._();
  UpdateTrackResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTrackResponse> createRepeated() =>
      $pb.PbList<UpdateTrackResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTrackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTrackResponse>(create);
  static UpdateTrackResponse? _defaultInstance;
}

class DeleteTrackRequest extends $pb.GeneratedMessage {
  factory DeleteTrackRequest({
    $core.String? trackId,
  }) {
    final $result = create();
    if (trackId != null) {
      $result.trackId = trackId;
    }
    return $result;
  }
  DeleteTrackRequest._() : super();
  factory DeleteTrackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteTrackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTrackRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteTrackRequest clone() => DeleteTrackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteTrackRequest copyWith(void Function(DeleteTrackRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteTrackRequest))
          as DeleteTrackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTrackRequest create() => DeleteTrackRequest._();
  DeleteTrackRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTrackRequest> createRepeated() =>
      $pb.PbList<DeleteTrackRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTrackRequest>(create);
  static DeleteTrackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);
}

class DeleteTrackResponse extends $pb.GeneratedMessage {
  factory DeleteTrackResponse() => create();
  DeleteTrackResponse._() : super();
  factory DeleteTrackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteTrackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTrackResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteTrackResponse clone() => DeleteTrackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteTrackResponse copyWith(void Function(DeleteTrackResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteTrackResponse))
          as DeleteTrackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTrackResponse create() => DeleteTrackResponse._();
  DeleteTrackResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteTrackResponse> createRepeated() =>
      $pb.PbList<DeleteTrackResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteTrackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTrackResponse>(create);
  static DeleteTrackResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
