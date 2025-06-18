//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/rt_session.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'device_instance.pb.dart' as $4;
import 'transport.pb.dart' as $5;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class StartRtSessionRequest extends $pb.GeneratedMessage {
  factory StartRtSessionRequest({
    $core.String? stateReceiverUri,
    $core.int? rtSessionId,
  }) {
    final $result = create();
    if (stateReceiverUri != null) {
      $result.stateReceiverUri = stateReceiverUri;
    }
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    return $result;
  }
  StartRtSessionRequest._() : super();
  factory StartRtSessionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartRtSessionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartRtSessionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stateReceiverUri')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartRtSessionRequest clone() =>
      StartRtSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartRtSessionRequest copyWith(
          void Function(StartRtSessionRequest) updates) =>
      super.copyWith((message) => updates(message as StartRtSessionRequest))
          as StartRtSessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartRtSessionRequest create() => StartRtSessionRequest._();
  StartRtSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StartRtSessionRequest> createRepeated() =>
      $pb.PbList<StartRtSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StartRtSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartRtSessionRequest>(create);
  static StartRtSessionRequest? _defaultInstance;

  /// 例:
  /// `udp://localhost:1234`
  @$pb.TagNumber(1)
  $core.String get stateReceiverUri => $_getSZ(0);
  @$pb.TagNumber(1)
  set stateReceiverUri($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStateReceiverUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearStateReceiverUri() => $_clearField(1);

  /// RtSession で用いられる session id。RtCommandBatch の送信時等に、NAM の session id として使われる。
  @$pb.TagNumber(2)
  $core.int get rtSessionId => $_getIZ(1);
  @$pb.TagNumber(2)
  set rtSessionId($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRtSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRtSessionId() => $_clearField(2);
}

class StartRtSessionResponse extends $pb.GeneratedMessage {
  factory StartRtSessionResponse({
    $core.String? commandReceiverUri,
  }) {
    final $result = create();
    if (commandReceiverUri != null) {
      $result.commandReceiverUri = commandReceiverUri;
    }
    return $result;
  }
  StartRtSessionResponse._() : super();
  factory StartRtSessionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartRtSessionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartRtSessionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'commandReceiverUri')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartRtSessionResponse clone() =>
      StartRtSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartRtSessionResponse copyWith(
          void Function(StartRtSessionResponse) updates) =>
      super.copyWith((message) => updates(message as StartRtSessionResponse))
          as StartRtSessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartRtSessionResponse create() => StartRtSessionResponse._();
  StartRtSessionResponse createEmptyInstance() => create();
  static $pb.PbList<StartRtSessionResponse> createRepeated() =>
      $pb.PbList<StartRtSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static StartRtSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartRtSessionResponse>(create);
  static StartRtSessionResponse? _defaultInstance;

  /// 例:
  /// `udp://localhost:1234`
  @$pb.TagNumber(1)
  $core.String get commandReceiverUri => $_getSZ(0);
  @$pb.TagNumber(1)
  set commandReceiverUri($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommandReceiverUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommandReceiverUri() => $_clearField(1);
}

class StopRtSessionRequest extends $pb.GeneratedMessage {
  factory StopRtSessionRequest({
    $core.int? rtSessionId,
  }) {
    final $result = create();
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    return $result;
  }
  StopRtSessionRequest._() : super();
  factory StopRtSessionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopRtSessionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopRtSessionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopRtSessionRequest clone() =>
      StopRtSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopRtSessionRequest copyWith(void Function(StopRtSessionRequest) updates) =>
      super.copyWith((message) => updates(message as StopRtSessionRequest))
          as StopRtSessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopRtSessionRequest create() => StopRtSessionRequest._();
  StopRtSessionRequest createEmptyInstance() => create();
  static $pb.PbList<StopRtSessionRequest> createRepeated() =>
      $pb.PbList<StopRtSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static StopRtSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopRtSessionRequest>(create);
  static StopRtSessionRequest? _defaultInstance;

  @$pb.TagNumber(3)
  $core.int get rtSessionId => $_getIZ(0);
  @$pb.TagNumber(3)
  set rtSessionId($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRtSessionId() => $_has(0);
  @$pb.TagNumber(3)
  void clearRtSessionId() => $_clearField(3);
}

class StopRtSessionResponse extends $pb.GeneratedMessage {
  factory StopRtSessionResponse() => create();
  StopRtSessionResponse._() : super();
  factory StopRtSessionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopRtSessionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopRtSessionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopRtSessionResponse clone() =>
      StopRtSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopRtSessionResponse copyWith(
          void Function(StopRtSessionResponse) updates) =>
      super.copyWith((message) => updates(message as StopRtSessionResponse))
          as StopRtSessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopRtSessionResponse create() => StopRtSessionResponse._();
  StopRtSessionResponse createEmptyInstance() => create();
  static $pb.PbList<StopRtSessionResponse> createRepeated() =>
      $pb.PbList<StopRtSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static StopRtSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopRtSessionResponse>(create);
  static StopRtSessionResponse? _defaultInstance;
}

enum RtCommandBatch_Command_Type { updateParameter, finalizeParameter, notSet }

class RtCommandBatch_Command extends $pb.GeneratedMessage {
  factory RtCommandBatch_Command({
    $4.RtUpdateParameterCommand? updateParameter,
    $4.RtFinalizeParameterCommand? finalizeParameter,
  }) {
    final $result = create();
    if (updateParameter != null) {
      $result.updateParameter = updateParameter;
    }
    if (finalizeParameter != null) {
      $result.finalizeParameter = finalizeParameter;
    }
    return $result;
  }
  RtCommandBatch_Command._() : super();
  factory RtCommandBatch_Command.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtCommandBatch_Command.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RtCommandBatch_Command_Type>
      _RtCommandBatch_Command_TypeByTag = {
    100: RtCommandBatch_Command_Type.updateParameter,
    101: RtCommandBatch_Command_Type.finalizeParameter,
    0: RtCommandBatch_Command_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtCommandBatch.Command',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [100, 101])
    ..aOM<$4.RtUpdateParameterCommand>(
        100, _omitFieldNames ? '' : 'updateParameter',
        subBuilder: $4.RtUpdateParameterCommand.create)
    ..aOM<$4.RtFinalizeParameterCommand>(
        101, _omitFieldNames ? '' : 'finalizeParameter',
        subBuilder: $4.RtFinalizeParameterCommand.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtCommandBatch_Command clone() =>
      RtCommandBatch_Command()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtCommandBatch_Command copyWith(
          void Function(RtCommandBatch_Command) updates) =>
      super.copyWith((message) => updates(message as RtCommandBatch_Command))
          as RtCommandBatch_Command;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtCommandBatch_Command create() => RtCommandBatch_Command._();
  RtCommandBatch_Command createEmptyInstance() => create();
  static $pb.PbList<RtCommandBatch_Command> createRepeated() =>
      $pb.PbList<RtCommandBatch_Command>();
  @$core.pragma('dart2js:noInline')
  static RtCommandBatch_Command getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtCommandBatch_Command>(create);
  static RtCommandBatch_Command? _defaultInstance;

  RtCommandBatch_Command_Type whichType() =>
      _RtCommandBatch_Command_TypeByTag[$_whichOneof(0)]!;
  void clearType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(100)
  $4.RtUpdateParameterCommand get updateParameter => $_getN(0);
  @$pb.TagNumber(100)
  set updateParameter($4.RtUpdateParameterCommand v) {
    $_setField(100, v);
  }

  @$pb.TagNumber(100)
  $core.bool hasUpdateParameter() => $_has(0);
  @$pb.TagNumber(100)
  void clearUpdateParameter() => $_clearField(100);
  @$pb.TagNumber(100)
  $4.RtUpdateParameterCommand ensureUpdateParameter() => $_ensure(0);

  @$pb.TagNumber(101)
  $4.RtFinalizeParameterCommand get finalizeParameter => $_getN(1);
  @$pb.TagNumber(101)
  set finalizeParameter($4.RtFinalizeParameterCommand v) {
    $_setField(101, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasFinalizeParameter() => $_has(1);
  @$pb.TagNumber(101)
  void clearFinalizeParameter() => $_clearField(101);
  @$pb.TagNumber(101)
  $4.RtFinalizeParameterCommand ensureFinalizeParameter() => $_ensure(1);
}

/// RtSession で用いられるメッセージ。command receiver （Engine）へ送られる。
class RtCommandBatch extends $pb.GeneratedMessage {
  factory RtCommandBatch({
    $core.Iterable<RtCommandBatch_Command>? commands,
  }) {
    final $result = create();
    if (commands != null) {
      $result.commands.addAll(commands);
    }
    return $result;
  }
  RtCommandBatch._() : super();
  factory RtCommandBatch.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtCommandBatch.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtCommandBatch',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pc<RtCommandBatch_Command>(
        1, _omitFieldNames ? '' : 'commands', $pb.PbFieldType.PM,
        subBuilder: RtCommandBatch_Command.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtCommandBatch clone() => RtCommandBatch()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtCommandBatch copyWith(void Function(RtCommandBatch) updates) =>
      super.copyWith((message) => updates(message as RtCommandBatch))
          as RtCommandBatch;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtCommandBatch create() => RtCommandBatch._();
  RtCommandBatch createEmptyInstance() => create();
  static $pb.PbList<RtCommandBatch> createRepeated() =>
      $pb.PbList<RtCommandBatch>();
  @$core.pragma('dart2js:noInline')
  static RtCommandBatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtCommandBatch>(create);
  static RtCommandBatch? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RtCommandBatch_Command> get commands => $_getList(0);
}

enum RtStateFragment_EngineEntity_Type { parameter, playhead, notSet }

class RtStateFragment_EngineEntity extends $pb.GeneratedMessage {
  factory RtStateFragment_EngineEntity({
    $4.RtParameter? parameter,
    $5.RtPlayheadPosition? playhead,
  }) {
    final $result = create();
    if (parameter != null) {
      $result.parameter = parameter;
    }
    if (playhead != null) {
      $result.playhead = playhead;
    }
    return $result;
  }
  RtStateFragment_EngineEntity._() : super();
  factory RtStateFragment_EngineEntity.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtStateFragment_EngineEntity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RtStateFragment_EngineEntity_Type>
      _RtStateFragment_EngineEntity_TypeByTag = {
    100: RtStateFragment_EngineEntity_Type.parameter,
    101: RtStateFragment_EngineEntity_Type.playhead,
    0: RtStateFragment_EngineEntity_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtStateFragment.EngineEntity',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [100, 101])
    ..aOM<$4.RtParameter>(100, _omitFieldNames ? '' : 'parameter',
        subBuilder: $4.RtParameter.create)
    ..aOM<$5.RtPlayheadPosition>(101, _omitFieldNames ? '' : 'playhead',
        subBuilder: $5.RtPlayheadPosition.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtStateFragment_EngineEntity clone() =>
      RtStateFragment_EngineEntity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtStateFragment_EngineEntity copyWith(
          void Function(RtStateFragment_EngineEntity) updates) =>
      super.copyWith(
              (message) => updates(message as RtStateFragment_EngineEntity))
          as RtStateFragment_EngineEntity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtStateFragment_EngineEntity create() =>
      RtStateFragment_EngineEntity._();
  RtStateFragment_EngineEntity createEmptyInstance() => create();
  static $pb.PbList<RtStateFragment_EngineEntity> createRepeated() =>
      $pb.PbList<RtStateFragment_EngineEntity>();
  @$core.pragma('dart2js:noInline')
  static RtStateFragment_EngineEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtStateFragment_EngineEntity>(create);
  static RtStateFragment_EngineEntity? _defaultInstance;

  RtStateFragment_EngineEntity_Type whichType() =>
      _RtStateFragment_EngineEntity_TypeByTag[$_whichOneof(0)]!;
  void clearType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(100)
  $4.RtParameter get parameter => $_getN(0);
  @$pb.TagNumber(100)
  set parameter($4.RtParameter v) {
    $_setField(100, v);
  }

  @$pb.TagNumber(100)
  $core.bool hasParameter() => $_has(0);
  @$pb.TagNumber(100)
  void clearParameter() => $_clearField(100);
  @$pb.TagNumber(100)
  $4.RtParameter ensureParameter() => $_ensure(0);

  @$pb.TagNumber(101)
  $5.RtPlayheadPosition get playhead => $_getN(1);
  @$pb.TagNumber(101)
  set playhead($5.RtPlayheadPosition v) {
    $_setField(101, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasPlayhead() => $_has(1);
  @$pb.TagNumber(101)
  void clearPlayhead() => $_clearField(101);
  @$pb.TagNumber(101)
  $5.RtPlayheadPosition ensurePlayhead() => $_ensure(1);
}

/// RtSession で転送されるメッセージ。Engine から state receiver へ送られる。
/// エンジン内に存在する Entity の状態を伝えるためのメッセージ。
/// 一度に全 Entity が送られるわけではなく、部分集合が送られる。
/// どの Entity の状態が含まれるかは、App 側からのリクエストを元に、
/// １パケットのデータサイズや、状態変更の有無を考慮してエンジン側で決定される。
class RtStateFragment extends $pb.GeneratedMessage {
  factory RtStateFragment({
    $core.Iterable<RtStateFragment_EngineEntity>? entitySubset,
  }) {
    final $result = create();
    if (entitySubset != null) {
      $result.entitySubset.addAll(entitySubset);
    }
    return $result;
  }
  RtStateFragment._() : super();
  factory RtStateFragment.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtStateFragment.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtStateFragment',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pc<RtStateFragment_EngineEntity>(
        1, _omitFieldNames ? '' : 'entitySubset', $pb.PbFieldType.PM,
        subBuilder: RtStateFragment_EngineEntity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtStateFragment clone() => RtStateFragment()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtStateFragment copyWith(void Function(RtStateFragment) updates) =>
      super.copyWith((message) => updates(message as RtStateFragment))
          as RtStateFragment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtStateFragment create() => RtStateFragment._();
  RtStateFragment createEmptyInstance() => create();
  static $pb.PbList<RtStateFragment> createRepeated() =>
      $pb.PbList<RtStateFragment>();
  @$core.pragma('dart2js:noInline')
  static RtStateFragment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtStateFragment>(create);
  static RtStateFragment? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RtStateFragment_EngineEntity> get entitySubset => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
