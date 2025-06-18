//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/connection.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/empty.pb.dart' as $7;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum Connection_Source { srcAudioTrackId, srcDeviceId, notSet }

enum Connection_Destination { destAudioOutput, destDeviceId, notSet }

/// デバイス、トラック、オーディオIO の間の接続。
/// コネクションの集合によってオーディオ信号やMIDI信号の流れ（オーディオグラフ）が決定する。
class Connection extends $pb.GeneratedMessage {
  factory Connection({
    $core.String? srcAudioTrackId,
    $core.String? srcDeviceId,
    $7.Empty? destAudioOutput,
    $core.String? destDeviceId,
  }) {
    final $result = create();
    if (srcAudioTrackId != null) {
      $result.srcAudioTrackId = srcAudioTrackId;
    }
    if (srcDeviceId != null) {
      $result.srcDeviceId = srcDeviceId;
    }
    if (destAudioOutput != null) {
      $result.destAudioOutput = destAudioOutput;
    }
    if (destDeviceId != null) {
      $result.destDeviceId = destDeviceId;
    }
    return $result;
  }
  Connection._() : super();
  factory Connection.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Connection.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Connection_Source> _Connection_SourceByTag =
      {
    101: Connection_Source.srcAudioTrackId,
    103: Connection_Source.srcDeviceId,
    0: Connection_Source.notSet
  };
  static const $core.Map<$core.int, Connection_Destination>
      _Connection_DestinationByTag = {
    201: Connection_Destination.destAudioOutput,
    202: Connection_Destination.destDeviceId,
    0: Connection_Destination.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Connection',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [101, 103])
    ..oo(1, [201, 202])
    ..aOS(101, _omitFieldNames ? '' : 'srcAudioTrackId')
    ..aOS(103, _omitFieldNames ? '' : 'srcDeviceId')
    ..aOM<$7.Empty>(201, _omitFieldNames ? '' : 'destAudioOutput',
        subBuilder: $7.Empty.create)
    ..aOS(202, _omitFieldNames ? '' : 'destDeviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Connection clone() => Connection()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Connection copyWith(void Function(Connection) updates) =>
      super.copyWith((message) => updates(message as Connection)) as Connection;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Connection create() => Connection._();
  Connection createEmptyInstance() => create();
  static $pb.PbList<Connection> createRepeated() => $pb.PbList<Connection>();
  @$core.pragma('dart2js:noInline')
  static Connection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Connection>(create);
  static Connection? _defaultInstance;

  Connection_Source whichSource() => _Connection_SourceByTag[$_whichOneof(0)]!;
  void clearSource() => $_clearField($_whichOneof(0));

  Connection_Destination whichDestination() =>
      _Connection_DestinationByTag[$_whichOneof(1)]!;
  void clearDestination() => $_clearField($_whichOneof(1));

  @$pb.TagNumber(101)
  $core.String get srcAudioTrackId => $_getSZ(0);
  @$pb.TagNumber(101)
  set srcAudioTrackId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasSrcAudioTrackId() => $_has(0);
  @$pb.TagNumber(101)
  void clearSrcAudioTrackId() => $_clearField(101);

  @$pb.TagNumber(103)
  $core.String get srcDeviceId => $_getSZ(1);
  @$pb.TagNumber(103)
  set srcDeviceId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(103)
  $core.bool hasSrcDeviceId() => $_has(1);
  @$pb.TagNumber(103)
  void clearSrcDeviceId() => $_clearField(103);

  @$pb.TagNumber(201)
  $7.Empty get destAudioOutput => $_getN(2);
  @$pb.TagNumber(201)
  set destAudioOutput($7.Empty v) {
    $_setField(201, v);
  }

  @$pb.TagNumber(201)
  $core.bool hasDestAudioOutput() => $_has(2);
  @$pb.TagNumber(201)
  void clearDestAudioOutput() => $_clearField(201);
  @$pb.TagNumber(201)
  $7.Empty ensureDestAudioOutput() => $_ensure(2);

  @$pb.TagNumber(202)
  $core.String get destDeviceId => $_getSZ(3);
  @$pb.TagNumber(202)
  set destDeviceId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(202)
  $core.bool hasDestDeviceId() => $_has(3);
  @$pb.TagNumber(202)
  void clearDestDeviceId() => $_clearField(202);
}

class ConnectRequest extends $pb.GeneratedMessage {
  factory ConnectRequest({
    Connection? connection,
  }) {
    final $result = create();
    if (connection != null) {
      $result.connection = connection;
    }
    return $result;
  }
  ConnectRequest._() : super();
  factory ConnectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConnectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConnectRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Connection>(2, _omitFieldNames ? '' : 'connection',
        subBuilder: Connection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConnectRequest clone() => ConnectRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConnectRequest copyWith(void Function(ConnectRequest) updates) =>
      super.copyWith((message) => updates(message as ConnectRequest))
          as ConnectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectRequest create() => ConnectRequest._();
  ConnectRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectRequest> createRepeated() =>
      $pb.PbList<ConnectRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectRequest>(create);
  static ConnectRequest? _defaultInstance;

  @$pb.TagNumber(2)
  Connection get connection => $_getN(0);
  @$pb.TagNumber(2)
  set connection(Connection v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(2)
  void clearConnection() => $_clearField(2);
  @$pb.TagNumber(2)
  Connection ensureConnection() => $_ensure(0);
}

class ConnectResponse extends $pb.GeneratedMessage {
  factory ConnectResponse() => create();
  ConnectResponse._() : super();
  factory ConnectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConnectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConnectResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConnectResponse clone() => ConnectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConnectResponse copyWith(void Function(ConnectResponse) updates) =>
      super.copyWith((message) => updates(message as ConnectResponse))
          as ConnectResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectResponse create() => ConnectResponse._();
  ConnectResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectResponse> createRepeated() =>
      $pb.PbList<ConnectResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConnectResponse>(create);
  static ConnectResponse? _defaultInstance;
}

class DisconnectRequest extends $pb.GeneratedMessage {
  factory DisconnectRequest({
    Connection? connection,
  }) {
    final $result = create();
    if (connection != null) {
      $result.connection = connection;
    }
    return $result;
  }
  DisconnectRequest._() : super();
  factory DisconnectRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisconnectRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisconnectRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Connection>(2, _omitFieldNames ? '' : 'connection',
        subBuilder: Connection.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisconnectRequest clone() => DisconnectRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisconnectRequest copyWith(void Function(DisconnectRequest) updates) =>
      super.copyWith((message) => updates(message as DisconnectRequest))
          as DisconnectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectRequest create() => DisconnectRequest._();
  DisconnectRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectRequest> createRepeated() =>
      $pb.PbList<DisconnectRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisconnectRequest>(create);
  static DisconnectRequest? _defaultInstance;

  @$pb.TagNumber(2)
  Connection get connection => $_getN(0);
  @$pb.TagNumber(2)
  set connection(Connection v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConnection() => $_has(0);
  @$pb.TagNumber(2)
  void clearConnection() => $_clearField(2);
  @$pb.TagNumber(2)
  Connection ensureConnection() => $_ensure(0);
}

class DisconnectResponse extends $pb.GeneratedMessage {
  factory DisconnectResponse() => create();
  DisconnectResponse._() : super();
  factory DisconnectResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisconnectResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisconnectResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisconnectResponse clone() => DisconnectResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisconnectResponse copyWith(void Function(DisconnectResponse) updates) =>
      super.copyWith((message) => updates(message as DisconnectResponse))
          as DisconnectResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectResponse create() => DisconnectResponse._();
  DisconnectResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectResponse> createRepeated() =>
      $pb.PbList<DisconnectResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisconnectResponse>(create);
  static DisconnectResponse? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
