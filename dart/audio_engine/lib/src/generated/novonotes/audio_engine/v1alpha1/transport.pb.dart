//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/transport.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/field_mask.pb.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Transport extends $pb.GeneratedMessage {
  factory Transport({
    $core.double? tempo,
    $core.double? playheadPosition,
    $core.double? loopStart,
    $core.double? loopDuration,
  }) {
    final $result = create();
    if (tempo != null) {
      $result.tempo = tempo;
    }
    if (playheadPosition != null) {
      $result.playheadPosition = playheadPosition;
    }
    if (loopStart != null) {
      $result.loopStart = loopStart;
    }
    if (loopDuration != null) {
      $result.loopDuration = loopDuration;
    }
    return $result;
  }
  Transport._() : super();
  factory Transport.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Transport.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transport',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'tempo', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'playheadPosition', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'loopStart', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'loopDuration', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Transport clone() => Transport()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Transport copyWith(void Function(Transport) updates) =>
      super.copyWith((message) => updates(message as Transport)) as Transport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transport create() => Transport._();
  Transport createEmptyInstance() => create();
  static $pb.PbList<Transport> createRepeated() => $pb.PbList<Transport>();
  @$core.pragma('dart2js:noInline')
  static Transport getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transport>(create);
  static Transport? _defaultInstance;

  ///  Tempo in quarter notes per minute (QNPM)。
  ///  120 の場合、1分間に120個の4分音符のスピードで再生。
  ///  4/4 などの 4分音符基準の拍子の場合、BPM と同じ。
  ///  3/8 などの 8分音符基準の拍子の場合、 BPM の 1/2 倍の数値。 （例: BPM=180 と QNPM=90 は同じテンポ）
  ///
  ///  0 と 0以下の値の場合、INVALID_ARGUMENT のエラー。
  @$pb.TagNumber(1)
  $core.double get tempo => $_getN(0);
  @$pb.TagNumber(1)
  set tempo($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTempo() => $_has(0);
  @$pb.TagNumber(1)
  void clearTempo() => $_clearField(1);

  /// 現在の再生位置
  /// Position in quarter note
  @$pb.TagNumber(2)
  $core.double get playheadPosition => $_getN(1);
  @$pb.TagNumber(2)
  set playheadPosition($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPlayheadPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayheadPosition() => $_clearField(2);

  /// ループの開始位置
  /// Position in quarter note
  @$pb.TagNumber(3)
  $core.double get loopStart => $_getN(2);
  @$pb.TagNumber(3)
  set loopStart($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLoopStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearLoopStart() => $_clearField(3);

  /// ループ範囲の長さ
  /// 0 より小さい値の場合、INVALID_ARGUMENT のエラー。
  /// Duration in quarter note
  @$pb.TagNumber(4)
  $core.double get loopDuration => $_getN(3);
  @$pb.TagNumber(4)
  set loopDuration($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLoopDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearLoopDuration() => $_clearField(4);
}

class UpdateTransportRequest extends $pb.GeneratedMessage {
  factory UpdateTransportRequest({
    Transport? transport,
    $3.FieldMask? updateMask,
  }) {
    final $result = create();
    if (transport != null) {
      $result.transport = transport;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateTransportRequest._() : super();
  factory UpdateTransportRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateTransportRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTransportRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Transport>(1, _omitFieldNames ? '' : 'transport',
        subBuilder: Transport.create)
    ..aOM<$3.FieldMask>(2, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $3.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateTransportRequest clone() =>
      UpdateTransportRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateTransportRequest copyWith(
          void Function(UpdateTransportRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTransportRequest))
          as UpdateTransportRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTransportRequest create() => UpdateTransportRequest._();
  UpdateTransportRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTransportRequest> createRepeated() =>
      $pb.PbList<UpdateTransportRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTransportRequest>(create);
  static UpdateTransportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Transport get transport => $_getN(0);
  @$pb.TagNumber(1)
  set transport(Transport v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransport() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransport() => $_clearField(1);
  @$pb.TagNumber(1)
  Transport ensureTransport() => $_ensure(0);

  @$pb.TagNumber(2)
  $3.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($3.FieldMask v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.FieldMask ensureUpdateMask() => $_ensure(1);
}

class UpdateTransportResponse extends $pb.GeneratedMessage {
  factory UpdateTransportResponse() => create();
  UpdateTransportResponse._() : super();
  factory UpdateTransportResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateTransportResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTransportResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateTransportResponse clone() =>
      UpdateTransportResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateTransportResponse copyWith(
          void Function(UpdateTransportResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateTransportResponse))
          as UpdateTransportResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTransportResponse create() => UpdateTransportResponse._();
  UpdateTransportResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTransportResponse> createRepeated() =>
      $pb.PbList<UpdateTransportResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTransportResponse>(create);
  static UpdateTransportResponse? _defaultInstance;
}

class StartPlaybackRequest extends $pb.GeneratedMessage {
  factory StartPlaybackRequest() => create();
  StartPlaybackRequest._() : super();
  factory StartPlaybackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartPlaybackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartPlaybackRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartPlaybackRequest clone() =>
      StartPlaybackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartPlaybackRequest copyWith(void Function(StartPlaybackRequest) updates) =>
      super.copyWith((message) => updates(message as StartPlaybackRequest))
          as StartPlaybackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartPlaybackRequest create() => StartPlaybackRequest._();
  StartPlaybackRequest createEmptyInstance() => create();
  static $pb.PbList<StartPlaybackRequest> createRepeated() =>
      $pb.PbList<StartPlaybackRequest>();
  @$core.pragma('dart2js:noInline')
  static StartPlaybackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartPlaybackRequest>(create);
  static StartPlaybackRequest? _defaultInstance;
}

class StartPlaybackResponse extends $pb.GeneratedMessage {
  factory StartPlaybackResponse() => create();
  StartPlaybackResponse._() : super();
  factory StartPlaybackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartPlaybackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartPlaybackResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartPlaybackResponse clone() =>
      StartPlaybackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartPlaybackResponse copyWith(
          void Function(StartPlaybackResponse) updates) =>
      super.copyWith((message) => updates(message as StartPlaybackResponse))
          as StartPlaybackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartPlaybackResponse create() => StartPlaybackResponse._();
  StartPlaybackResponse createEmptyInstance() => create();
  static $pb.PbList<StartPlaybackResponse> createRepeated() =>
      $pb.PbList<StartPlaybackResponse>();
  @$core.pragma('dart2js:noInline')
  static StartPlaybackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartPlaybackResponse>(create);
  static StartPlaybackResponse? _defaultInstance;
}

class StopPlaybackRequest extends $pb.GeneratedMessage {
  factory StopPlaybackRequest() => create();
  StopPlaybackRequest._() : super();
  factory StopPlaybackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopPlaybackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopPlaybackRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopPlaybackRequest clone() => StopPlaybackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopPlaybackRequest copyWith(void Function(StopPlaybackRequest) updates) =>
      super.copyWith((message) => updates(message as StopPlaybackRequest))
          as StopPlaybackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopPlaybackRequest create() => StopPlaybackRequest._();
  StopPlaybackRequest createEmptyInstance() => create();
  static $pb.PbList<StopPlaybackRequest> createRepeated() =>
      $pb.PbList<StopPlaybackRequest>();
  @$core.pragma('dart2js:noInline')
  static StopPlaybackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopPlaybackRequest>(create);
  static StopPlaybackRequest? _defaultInstance;
}

class StopPlaybackResponse extends $pb.GeneratedMessage {
  factory StopPlaybackResponse() => create();
  StopPlaybackResponse._() : super();
  factory StopPlaybackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopPlaybackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopPlaybackResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopPlaybackResponse clone() =>
      StopPlaybackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopPlaybackResponse copyWith(void Function(StopPlaybackResponse) updates) =>
      super.copyWith((message) => updates(message as StopPlaybackResponse))
          as StopPlaybackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopPlaybackResponse create() => StopPlaybackResponse._();
  StopPlaybackResponse createEmptyInstance() => create();
  static $pb.PbList<StopPlaybackResponse> createRepeated() =>
      $pb.PbList<StopPlaybackResponse>();
  @$core.pragma('dart2js:noInline')
  static StopPlaybackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopPlaybackResponse>(create);
  static StopPlaybackResponse? _defaultInstance;
}

/// Playhead 位置についてのリアルタイムデータストリームを開始するリクエスト
/// 現在サポートされているのは UDP での送信のみ。
class StartPlayheadPositionStreamRequest extends $pb.GeneratedMessage {
  factory StartPlayheadPositionStreamRequest({
    $core.int? rtSessionId,
  }) {
    final $result = create();
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    return $result;
  }
  StartPlayheadPositionStreamRequest._() : super();
  factory StartPlayheadPositionStreamRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartPlayheadPositionStreamRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartPlayheadPositionStreamRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartPlayheadPositionStreamRequest clone() =>
      StartPlayheadPositionStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartPlayheadPositionStreamRequest copyWith(
          void Function(StartPlayheadPositionStreamRequest) updates) =>
      super.copyWith((message) =>
              updates(message as StartPlayheadPositionStreamRequest))
          as StartPlayheadPositionStreamRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartPlayheadPositionStreamRequest create() =>
      StartPlayheadPositionStreamRequest._();
  StartPlayheadPositionStreamRequest createEmptyInstance() => create();
  static $pb.PbList<StartPlayheadPositionStreamRequest> createRepeated() =>
      $pb.PbList<StartPlayheadPositionStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static StartPlayheadPositionStreamRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartPlayheadPositionStreamRequest>(
          create);
  static StartPlayheadPositionStreamRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get rtSessionId => $_getIZ(0);
  @$pb.TagNumber(2)
  set rtSessionId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRtSessionId() => $_has(0);
  @$pb.TagNumber(2)
  void clearRtSessionId() => $_clearField(2);
}

class StartPlayheadPositionStreamResponse extends $pb.GeneratedMessage {
  factory StartPlayheadPositionStreamResponse() => create();
  StartPlayheadPositionStreamResponse._() : super();
  factory StartPlayheadPositionStreamResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartPlayheadPositionStreamResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartPlayheadPositionStreamResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartPlayheadPositionStreamResponse clone() =>
      StartPlayheadPositionStreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartPlayheadPositionStreamResponse copyWith(
          void Function(StartPlayheadPositionStreamResponse) updates) =>
      super.copyWith((message) =>
              updates(message as StartPlayheadPositionStreamResponse))
          as StartPlayheadPositionStreamResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartPlayheadPositionStreamResponse create() =>
      StartPlayheadPositionStreamResponse._();
  StartPlayheadPositionStreamResponse createEmptyInstance() => create();
  static $pb.PbList<StartPlayheadPositionStreamResponse> createRepeated() =>
      $pb.PbList<StartPlayheadPositionStreamResponse>();
  @$core.pragma('dart2js:noInline')
  static StartPlayheadPositionStreamResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          StartPlayheadPositionStreamResponse>(create);
  static StartPlayheadPositionStreamResponse? _defaultInstance;
}

class StopPlayheadPositionStreamRequest extends $pb.GeneratedMessage {
  factory StopPlayheadPositionStreamRequest({
    $core.int? rtSessionId,
  }) {
    final $result = create();
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    return $result;
  }
  StopPlayheadPositionStreamRequest._() : super();
  factory StopPlayheadPositionStreamRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopPlayheadPositionStreamRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopPlayheadPositionStreamRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopPlayheadPositionStreamRequest clone() =>
      StopPlayheadPositionStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopPlayheadPositionStreamRequest copyWith(
          void Function(StopPlayheadPositionStreamRequest) updates) =>
      super.copyWith((message) =>
              updates(message as StopPlayheadPositionStreamRequest))
          as StopPlayheadPositionStreamRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopPlayheadPositionStreamRequest create() =>
      StopPlayheadPositionStreamRequest._();
  StopPlayheadPositionStreamRequest createEmptyInstance() => create();
  static $pb.PbList<StopPlayheadPositionStreamRequest> createRepeated() =>
      $pb.PbList<StopPlayheadPositionStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static StopPlayheadPositionStreamRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopPlayheadPositionStreamRequest>(
          create);
  static StopPlayheadPositionStreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rtSessionId => $_getIZ(0);
  @$pb.TagNumber(1)
  set rtSessionId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRtSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRtSessionId() => $_clearField(1);
}

class StopPlayheadPositionStreamResponse extends $pb.GeneratedMessage {
  factory StopPlayheadPositionStreamResponse() => create();
  StopPlayheadPositionStreamResponse._() : super();
  factory StopPlayheadPositionStreamResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopPlayheadPositionStreamResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopPlayheadPositionStreamResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopPlayheadPositionStreamResponse clone() =>
      StopPlayheadPositionStreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopPlayheadPositionStreamResponse copyWith(
          void Function(StopPlayheadPositionStreamResponse) updates) =>
      super.copyWith((message) =>
              updates(message as StopPlayheadPositionStreamResponse))
          as StopPlayheadPositionStreamResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopPlayheadPositionStreamResponse create() =>
      StopPlayheadPositionStreamResponse._();
  StopPlayheadPositionStreamResponse createEmptyInstance() => create();
  static $pb.PbList<StopPlayheadPositionStreamResponse> createRepeated() =>
      $pb.PbList<StopPlayheadPositionStreamResponse>();
  @$core.pragma('dart2js:noInline')
  static StopPlayheadPositionStreamResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopPlayheadPositionStreamResponse>(
          create);
  static StopPlayheadPositionStreamResponse? _defaultInstance;
}

class RtPlayheadPosition extends $pb.GeneratedMessage {
  factory RtPlayheadPosition({
    $core.int? sequenceNumber,
    $core.double? positionPpq,
    $core.double? positionSeconds,
    $fixnum.Int64? positionSamples,
  }) {
    final $result = create();
    if (sequenceNumber != null) {
      $result.sequenceNumber = sequenceNumber;
    }
    if (positionPpq != null) {
      $result.positionPpq = positionPpq;
    }
    if (positionSeconds != null) {
      $result.positionSeconds = positionSeconds;
    }
    if (positionSamples != null) {
      $result.positionSamples = positionSamples;
    }
    return $result;
  }
  RtPlayheadPosition._() : super();
  factory RtPlayheadPosition.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtPlayheadPosition.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtPlayheadPosition',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'sequenceNumber', $pb.PbFieldType.O3)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'positionPpq', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'positionSeconds', $pb.PbFieldType.OD)
    ..aInt64(4, _omitFieldNames ? '' : 'positionSamples')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtPlayheadPosition clone() => RtPlayheadPosition()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtPlayheadPosition copyWith(void Function(RtPlayheadPosition) updates) =>
      super.copyWith((message) => updates(message as RtPlayheadPosition))
          as RtPlayheadPosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtPlayheadPosition create() => RtPlayheadPosition._();
  RtPlayheadPosition createEmptyInstance() => create();
  static $pb.PbList<RtPlayheadPosition> createRepeated() =>
      $pb.PbList<RtPlayheadPosition>();
  @$core.pragma('dart2js:noInline')
  static RtPlayheadPosition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtPlayheadPosition>(create);
  static RtPlayheadPosition? _defaultInstance;

  /// Wrap-around
  @$pb.TagNumber(1)
  $core.int get sequenceNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set sequenceNumber($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSequenceNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceNumber() => $_clearField(1);

  /// The current playhead position in quarter notes.
  @$pb.TagNumber(2)
  $core.double get positionPpq => $_getN(1);
  @$pb.TagNumber(2)
  set positionPpq($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPositionPpq() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionPpq() => $_clearField(2);

  /// The current playhead position in seconds.
  @$pb.TagNumber(3)
  $core.double get positionSeconds => $_getN(2);
  @$pb.TagNumber(3)
  set positionSeconds($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPositionSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionSeconds() => $_clearField(3);

  /// The current playhead position in samples.
  @$pb.TagNumber(4)
  $fixnum.Int64 get positionSamples => $_getI64(3);
  @$pb.TagNumber(4)
  set positionSamples($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPositionSamples() => $_has(3);
  @$pb.TagNumber(4)
  void clearPositionSamples() => $_clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
