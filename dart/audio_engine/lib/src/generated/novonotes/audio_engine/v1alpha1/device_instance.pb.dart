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

import '../../../google/protobuf/struct.pb.dart' as $2;
import 'device_instance.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'device_instance.pbenum.dart';

/// リアルタイムにオーディオ/MIDIを処理するモジュール。
/// 具体的には、ビルトインの音量調整モジュール、パンナー、インストルメント、オーディオエフェクト、VST/AU プラグインのインスタンスなど。
class DeviceInstance extends $pb.GeneratedMessage {
  factory DeviceInstance({
    $core.String? id,
    $core.String? deviceTypeId,
    $core.String? stateRestorationToken,
    $pb.PbMap<$core.String, DeviceParameter>? parameters,
    $core.Iterable<DeviceIo>? inlets,
    $core.Iterable<DeviceIo>? outlets,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (deviceTypeId != null) {
      $result.deviceTypeId = deviceTypeId;
    }
    if (stateRestorationToken != null) {
      $result.stateRestorationToken = stateRestorationToken;
    }
    if (parameters != null) {
      $result.parameters.addAll(parameters);
    }
    if (inlets != null) {
      $result.inlets.addAll(inlets);
    }
    if (outlets != null) {
      $result.outlets.addAll(outlets);
    }
    return $result;
  }
  DeviceInstance._() : super();
  factory DeviceInstance.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceInstance.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceInstance',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'deviceTypeId')
    ..aOS(3, _omitFieldNames ? '' : 'stateRestorationToken')
    ..m<$core.String, DeviceParameter>(4, _omitFieldNames ? '' : 'parameters',
        entryClassName: 'DeviceInstance.ParametersEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: DeviceParameter.create,
        valueDefaultOrMaker: DeviceParameter.getDefault,
        packageName: const $pb.PackageName('novonotes.audio_engine.v1alpha1'))
    ..pc<DeviceIo>(5, _omitFieldNames ? '' : 'inlets', $pb.PbFieldType.PM,
        subBuilder: DeviceIo.create)
    ..pc<DeviceIo>(6, _omitFieldNames ? '' : 'outlets', $pb.PbFieldType.PM,
        subBuilder: DeviceIo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceInstance clone() => DeviceInstance()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceInstance copyWith(void Function(DeviceInstance) updates) =>
      super.copyWith((message) => updates(message as DeviceInstance))
          as DeviceInstance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceInstance create() => DeviceInstance._();
  DeviceInstance createEmptyInstance() => create();
  static $pb.PbList<DeviceInstance> createRepeated() =>
      $pb.PbList<DeviceInstance>();
  @$core.pragma('dart2js:noInline')
  static DeviceInstance getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceInstance>(create);
  static DeviceInstance? _defaultInstance;

  /// ユーザー指定の id 。
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
  $core.String get deviceTypeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceTypeId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDeviceTypeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceTypeId() => $_clearField(2);

  /// このデバイスの内部状態を復元する際に必要なトークン。
  @$pb.TagNumber(3)
  $core.String get stateRestorationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set stateRestorationToken($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasStateRestorationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearStateRestorationToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, DeviceParameter> get parameters => $_getMap(3);

  @$pb.TagNumber(5)
  $pb.PbList<DeviceIo> get inlets => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<DeviceIo> get outlets => $_getList(5);
}

/// Represents parameter type with Integer/Float value.
class DeviceParameter_NumericType extends $pb.GeneratedMessage {
  factory DeviceParameter_NumericType({
    $core.double? normalizedCurrentValue,
    $core.double? normalizedDefaultValue,
    $core.String? minValue,
    $core.String? maxValue,
    $core.int? stepCount,
  }) {
    final $result = create();
    if (normalizedCurrentValue != null) {
      $result.normalizedCurrentValue = normalizedCurrentValue;
    }
    if (normalizedDefaultValue != null) {
      $result.normalizedDefaultValue = normalizedDefaultValue;
    }
    if (minValue != null) {
      $result.minValue = minValue;
    }
    if (maxValue != null) {
      $result.maxValue = maxValue;
    }
    if (stepCount != null) {
      $result.stepCount = stepCount;
    }
    return $result;
  }
  DeviceParameter_NumericType._() : super();
  factory DeviceParameter_NumericType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceParameter_NumericType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceParameter.NumericType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'normalizedCurrentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'normalizedDefaultValue', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'minValue')
    ..aOS(4, _omitFieldNames ? '' : 'maxValue')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'stepCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceParameter_NumericType clone() =>
      DeviceParameter_NumericType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceParameter_NumericType copyWith(
          void Function(DeviceParameter_NumericType) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceParameter_NumericType))
          as DeviceParameter_NumericType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceParameter_NumericType create() =>
      DeviceParameter_NumericType._();
  DeviceParameter_NumericType createEmptyInstance() => create();
  static $pb.PbList<DeviceParameter_NumericType> createRepeated() =>
      $pb.PbList<DeviceParameter_NumericType>();
  @$core.pragma('dart2js:noInline')
  static DeviceParameter_NumericType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceParameter_NumericType>(create);
  static DeviceParameter_NumericType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get normalizedCurrentValue => $_getN(0);
  @$pb.TagNumber(1)
  set normalizedCurrentValue($core.double v) {
    $_setDouble(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNormalizedCurrentValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearNormalizedCurrentValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get normalizedDefaultValue => $_getN(1);
  @$pb.TagNumber(2)
  set normalizedDefaultValue($core.double v) {
    $_setDouble(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNormalizedDefaultValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearNormalizedDefaultValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get minValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set minValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMinValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get maxValue => $_getSZ(3);
  @$pb.TagNumber(4)
  set maxValue($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMaxValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get stepCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set stepCount($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStepCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearStepCount() => $_clearField(5);
}

/// Represents parameter type with Bool/Enum value.
class DeviceParameter_ChoiceType extends $pb.GeneratedMessage {
  factory DeviceParameter_ChoiceType({
    $core.Iterable<$core.String>? options,
  }) {
    final $result = create();
    if (options != null) {
      $result.options.addAll(options);
    }
    return $result;
  }
  DeviceParameter_ChoiceType._() : super();
  factory DeviceParameter_ChoiceType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceParameter_ChoiceType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceParameter.ChoiceType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'options')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceParameter_ChoiceType clone() =>
      DeviceParameter_ChoiceType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceParameter_ChoiceType copyWith(
          void Function(DeviceParameter_ChoiceType) updates) =>
      super.copyWith(
              (message) => updates(message as DeviceParameter_ChoiceType))
          as DeviceParameter_ChoiceType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceParameter_ChoiceType create() => DeviceParameter_ChoiceType._();
  DeviceParameter_ChoiceType createEmptyInstance() => create();
  static $pb.PbList<DeviceParameter_ChoiceType> createRepeated() =>
      $pb.PbList<DeviceParameter_ChoiceType>();
  @$core.pragma('dart2js:noInline')
  static DeviceParameter_ChoiceType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceParameter_ChoiceType>(create);
  static DeviceParameter_ChoiceType? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get options => $_getList(0);
}

enum DeviceParameter_ParameterType { numeric, choice, notSet }

class DeviceParameter extends $pb.GeneratedMessage {
  factory DeviceParameter({
    $core.String? id,
    $core.String? displayName,
    $core.String? currentValue,
    $core.String? defaultValue,
    $core.String? parameterSyncKey,
    DeviceParameter_NumericType? numeric,
    DeviceParameter_ChoiceType? choice,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (currentValue != null) {
      $result.currentValue = currentValue;
    }
    if (defaultValue != null) {
      $result.defaultValue = defaultValue;
    }
    if (parameterSyncKey != null) {
      $result.parameterSyncKey = parameterSyncKey;
    }
    if (numeric != null) {
      $result.numeric = numeric;
    }
    if (choice != null) {
      $result.choice = choice;
    }
    return $result;
  }
  DeviceParameter._() : super();
  factory DeviceParameter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceParameter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, DeviceParameter_ParameterType>
      _DeviceParameter_ParameterTypeByTag = {
    101: DeviceParameter_ParameterType.numeric,
    102: DeviceParameter_ParameterType.choice,
    0: DeviceParameter_ParameterType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceParameter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [101, 102])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'currentValue')
    ..aOS(4, _omitFieldNames ? '' : 'defaultValue')
    ..aOS(5, _omitFieldNames ? '' : 'parameterSyncKey')
    ..aOM<DeviceParameter_NumericType>(101, _omitFieldNames ? '' : 'numeric',
        subBuilder: DeviceParameter_NumericType.create)
    ..aOM<DeviceParameter_ChoiceType>(102, _omitFieldNames ? '' : 'choice',
        subBuilder: DeviceParameter_ChoiceType.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceParameter clone() => DeviceParameter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceParameter copyWith(void Function(DeviceParameter) updates) =>
      super.copyWith((message) => updates(message as DeviceParameter))
          as DeviceParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceParameter create() => DeviceParameter._();
  DeviceParameter createEmptyInstance() => create();
  static $pb.PbList<DeviceParameter> createRepeated() =>
      $pb.PbList<DeviceParameter>();
  @$core.pragma('dart2js:noInline')
  static DeviceParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceParameter>(create);
  static DeviceParameter? _defaultInstance;

  DeviceParameter_ParameterType whichParameterType() =>
      _DeviceParameter_ParameterTypeByTag[$_whichOneof(0)]!;
  void clearParameterType() => $_clearField($_whichOneof(0));

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
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currentValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set currentValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCurrentValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get defaultValue => $_getSZ(3);
  @$pb.TagNumber(4)
  set defaultValue($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDefaultValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearDefaultValue() => $_clearField(4);

  /// ParameterSync の際に用いるキー。
  /// パラメーターごとに異なる一意のキーが付与されます。
  @$pb.TagNumber(5)
  $core.String get parameterSyncKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set parameterSyncKey($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasParameterSyncKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearParameterSyncKey() => $_clearField(5);

  @$pb.TagNumber(101)
  DeviceParameter_NumericType get numeric => $_getN(5);
  @$pb.TagNumber(101)
  set numeric(DeviceParameter_NumericType v) {
    $_setField(101, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasNumeric() => $_has(5);
  @$pb.TagNumber(101)
  void clearNumeric() => $_clearField(101);
  @$pb.TagNumber(101)
  DeviceParameter_NumericType ensureNumeric() => $_ensure(5);

  @$pb.TagNumber(102)
  DeviceParameter_ChoiceType get choice => $_getN(6);
  @$pb.TagNumber(102)
  set choice(DeviceParameter_ChoiceType v) {
    $_setField(102, v);
  }

  @$pb.TagNumber(102)
  $core.bool hasChoice() => $_has(6);
  @$pb.TagNumber(102)
  void clearChoice() => $_clearField(102);
  @$pb.TagNumber(102)
  DeviceParameter_ChoiceType ensureChoice() => $_ensure(6);
}

class DeviceIo extends $pb.GeneratedMessage {
  factory DeviceIo({
    $core.String? displayName,
  }) {
    final $result = create();
    if (displayName != null) {
      $result.displayName = displayName;
    }
    return $result;
  }
  DeviceIo._() : super();
  factory DeviceIo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceIo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceIo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceIo clone() => DeviceIo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceIo copyWith(void Function(DeviceIo) updates) =>
      super.copyWith((message) => updates(message as DeviceIo)) as DeviceIo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceIo create() => DeviceIo._();
  DeviceIo createEmptyInstance() => create();
  static $pb.PbList<DeviceIo> createRepeated() => $pb.PbList<DeviceIo>();
  @$core.pragma('dart2js:noInline')
  static DeviceIo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceIo>(create);
  static DeviceIo? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);
}

class CreateDeviceInstanceRequest extends $pb.GeneratedMessage {
  factory CreateDeviceInstanceRequest({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  CreateDeviceInstanceRequest._() : super();
  factory CreateDeviceInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateDeviceInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDeviceInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateDeviceInstanceRequest clone() =>
      CreateDeviceInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateDeviceInstanceRequest copyWith(
          void Function(CreateDeviceInstanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDeviceInstanceRequest))
          as CreateDeviceInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDeviceInstanceRequest create() =>
      CreateDeviceInstanceRequest._();
  CreateDeviceInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDeviceInstanceRequest> createRepeated() =>
      $pb.PbList<CreateDeviceInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDeviceInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDeviceInstanceRequest>(create);
  static CreateDeviceInstanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

class CreateDeviceInstanceResponse extends $pb.GeneratedMessage {
  factory CreateDeviceInstanceResponse({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  CreateDeviceInstanceResponse._() : super();
  factory CreateDeviceInstanceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateDeviceInstanceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDeviceInstanceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateDeviceInstanceResponse clone() =>
      CreateDeviceInstanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateDeviceInstanceResponse copyWith(
          void Function(CreateDeviceInstanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDeviceInstanceResponse))
          as CreateDeviceInstanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDeviceInstanceResponse create() =>
      CreateDeviceInstanceResponse._();
  CreateDeviceInstanceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateDeviceInstanceResponse> createRepeated() =>
      $pb.PbList<CreateDeviceInstanceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateDeviceInstanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDeviceInstanceResponse>(create);
  static CreateDeviceInstanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

class DeleteDeviceInstanceRequest extends $pb.GeneratedMessage {
  factory DeleteDeviceInstanceRequest({
    $core.String? deviceInstanceId,
  }) {
    final $result = create();
    if (deviceInstanceId != null) {
      $result.deviceInstanceId = deviceInstanceId;
    }
    return $result;
  }
  DeleteDeviceInstanceRequest._() : super();
  factory DeleteDeviceInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteDeviceInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteDeviceInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInstanceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteDeviceInstanceRequest clone() =>
      DeleteDeviceInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteDeviceInstanceRequest copyWith(
          void Function(DeleteDeviceInstanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteDeviceInstanceRequest))
          as DeleteDeviceInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDeviceInstanceRequest create() =>
      DeleteDeviceInstanceRequest._();
  DeleteDeviceInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteDeviceInstanceRequest> createRepeated() =>
      $pb.PbList<DeleteDeviceInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteDeviceInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteDeviceInstanceRequest>(create);
  static DeleteDeviceInstanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstanceId() => $_clearField(1);
}

class DeleteDeviceInstanceResponse extends $pb.GeneratedMessage {
  factory DeleteDeviceInstanceResponse() => create();
  DeleteDeviceInstanceResponse._() : super();
  factory DeleteDeviceInstanceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteDeviceInstanceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteDeviceInstanceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteDeviceInstanceResponse clone() =>
      DeleteDeviceInstanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteDeviceInstanceResponse copyWith(
          void Function(DeleteDeviceInstanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteDeviceInstanceResponse))
          as DeleteDeviceInstanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDeviceInstanceResponse create() =>
      DeleteDeviceInstanceResponse._();
  DeleteDeviceInstanceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteDeviceInstanceResponse> createRepeated() =>
      $pb.PbList<DeleteDeviceInstanceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteDeviceInstanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteDeviceInstanceResponse>(create);
  static DeleteDeviceInstanceResponse? _defaultInstance;
}

class GetDeviceInstanceRequest extends $pb.GeneratedMessage {
  factory GetDeviceInstanceRequest({
    $core.String? deviceInstanceId,
  }) {
    final $result = create();
    if (deviceInstanceId != null) {
      $result.deviceInstanceId = deviceInstanceId;
    }
    return $result;
  }
  GetDeviceInstanceRequest._() : super();
  factory GetDeviceInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDeviceInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeviceInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInstanceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDeviceInstanceRequest clone() =>
      GetDeviceInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDeviceInstanceRequest copyWith(
          void Function(GetDeviceInstanceRequest) updates) =>
      super.copyWith((message) => updates(message as GetDeviceInstanceRequest))
          as GetDeviceInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeviceInstanceRequest create() => GetDeviceInstanceRequest._();
  GetDeviceInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetDeviceInstanceRequest> createRepeated() =>
      $pb.PbList<GetDeviceInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDeviceInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeviceInstanceRequest>(create);
  static GetDeviceInstanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstanceId() => $_clearField(1);
}

class GetDeviceInstanceResponse extends $pb.GeneratedMessage {
  factory GetDeviceInstanceResponse({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  GetDeviceInstanceResponse._() : super();
  factory GetDeviceInstanceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDeviceInstanceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDeviceInstanceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDeviceInstanceResponse clone() =>
      GetDeviceInstanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDeviceInstanceResponse copyWith(
          void Function(GetDeviceInstanceResponse) updates) =>
      super.copyWith((message) => updates(message as GetDeviceInstanceResponse))
          as GetDeviceInstanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDeviceInstanceResponse create() => GetDeviceInstanceResponse._();
  GetDeviceInstanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetDeviceInstanceResponse> createRepeated() =>
      $pb.PbList<GetDeviceInstanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDeviceInstanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDeviceInstanceResponse>(create);
  static GetDeviceInstanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

class SubscribeToDeviceInstanceUpdatesRequest extends $pb.GeneratedMessage {
  factory SubscribeToDeviceInstanceUpdatesRequest() => create();
  SubscribeToDeviceInstanceUpdatesRequest._() : super();
  factory SubscribeToDeviceInstanceUpdatesRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeToDeviceInstanceUpdatesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeToDeviceInstanceUpdatesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubscribeToDeviceInstanceUpdatesRequest clone() =>
      SubscribeToDeviceInstanceUpdatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubscribeToDeviceInstanceUpdatesRequest copyWith(
          void Function(SubscribeToDeviceInstanceUpdatesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as SubscribeToDeviceInstanceUpdatesRequest))
          as SubscribeToDeviceInstanceUpdatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeToDeviceInstanceUpdatesRequest create() =>
      SubscribeToDeviceInstanceUpdatesRequest._();
  SubscribeToDeviceInstanceUpdatesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeToDeviceInstanceUpdatesRequest> createRepeated() =>
      $pb.PbList<SubscribeToDeviceInstanceUpdatesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToDeviceInstanceUpdatesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          SubscribeToDeviceInstanceUpdatesRequest>(create);
  static SubscribeToDeviceInstanceUpdatesRequest? _defaultInstance;
}

/// Stream の response。一つの Request に対して、複数回送られる。
class SubscribeToDeviceInstanceUpdatesResponse extends $pb.GeneratedMessage {
  factory SubscribeToDeviceInstanceUpdatesResponse({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  SubscribeToDeviceInstanceUpdatesResponse._() : super();
  factory SubscribeToDeviceInstanceUpdatesResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeToDeviceInstanceUpdatesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeToDeviceInstanceUpdatesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubscribeToDeviceInstanceUpdatesResponse clone() =>
      SubscribeToDeviceInstanceUpdatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubscribeToDeviceInstanceUpdatesResponse copyWith(
          void Function(SubscribeToDeviceInstanceUpdatesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as SubscribeToDeviceInstanceUpdatesResponse))
          as SubscribeToDeviceInstanceUpdatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeToDeviceInstanceUpdatesResponse create() =>
      SubscribeToDeviceInstanceUpdatesResponse._();
  SubscribeToDeviceInstanceUpdatesResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeToDeviceInstanceUpdatesResponse>
      createRepeated() =>
          $pb.PbList<SubscribeToDeviceInstanceUpdatesResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeToDeviceInstanceUpdatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          SubscribeToDeviceInstanceUpdatesResponse>(create);
  static SubscribeToDeviceInstanceUpdatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

class RestoreDeviceInstanceStateRequest extends $pb.GeneratedMessage {
  factory RestoreDeviceInstanceStateRequest({
    $core.String? deviceInstanceId,
    $core.String? stateRestorationToken,
  }) {
    final $result = create();
    if (deviceInstanceId != null) {
      $result.deviceInstanceId = deviceInstanceId;
    }
    if (stateRestorationToken != null) {
      $result.stateRestorationToken = stateRestorationToken;
    }
    return $result;
  }
  RestoreDeviceInstanceStateRequest._() : super();
  factory RestoreDeviceInstanceStateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RestoreDeviceInstanceStateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RestoreDeviceInstanceStateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInstanceId')
    ..aOS(2, _omitFieldNames ? '' : 'stateRestorationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RestoreDeviceInstanceStateRequest clone() =>
      RestoreDeviceInstanceStateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RestoreDeviceInstanceStateRequest copyWith(
          void Function(RestoreDeviceInstanceStateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as RestoreDeviceInstanceStateRequest))
          as RestoreDeviceInstanceStateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RestoreDeviceInstanceStateRequest create() =>
      RestoreDeviceInstanceStateRequest._();
  RestoreDeviceInstanceStateRequest createEmptyInstance() => create();
  static $pb.PbList<RestoreDeviceInstanceStateRequest> createRepeated() =>
      $pb.PbList<RestoreDeviceInstanceStateRequest>();
  @$core.pragma('dart2js:noInline')
  static RestoreDeviceInstanceStateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RestoreDeviceInstanceStateRequest>(
          create);
  static RestoreDeviceInstanceStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstanceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get stateRestorationToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set stateRestorationToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStateRestorationToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearStateRestorationToken() => $_clearField(2);
}

class RestoreDeviceInstanceStateResponse extends $pb.GeneratedMessage {
  factory RestoreDeviceInstanceStateResponse({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  RestoreDeviceInstanceStateResponse._() : super();
  factory RestoreDeviceInstanceStateResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RestoreDeviceInstanceStateResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RestoreDeviceInstanceStateResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RestoreDeviceInstanceStateResponse clone() =>
      RestoreDeviceInstanceStateResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RestoreDeviceInstanceStateResponse copyWith(
          void Function(RestoreDeviceInstanceStateResponse) updates) =>
      super.copyWith((message) =>
              updates(message as RestoreDeviceInstanceStateResponse))
          as RestoreDeviceInstanceStateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RestoreDeviceInstanceStateResponse create() =>
      RestoreDeviceInstanceStateResponse._();
  RestoreDeviceInstanceStateResponse createEmptyInstance() => create();
  static $pb.PbList<RestoreDeviceInstanceStateResponse> createRepeated() =>
      $pb.PbList<RestoreDeviceInstanceStateResponse>();
  @$core.pragma('dart2js:noInline')
  static RestoreDeviceInstanceStateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RestoreDeviceInstanceStateResponse>(
          create);
  static RestoreDeviceInstanceStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

enum SetParameterValueRequest_NewValue { textValue, normalizedValue, notSet }

class SetParameterValueRequest extends $pb.GeneratedMessage {
  factory SetParameterValueRequest({
    $core.String? deviceInstanceId,
    $core.String? parameterId,
    $core.String? textValue,
    $core.double? normalizedValue,
  }) {
    final $result = create();
    if (deviceInstanceId != null) {
      $result.deviceInstanceId = deviceInstanceId;
    }
    if (parameterId != null) {
      $result.parameterId = parameterId;
    }
    if (textValue != null) {
      $result.textValue = textValue;
    }
    if (normalizedValue != null) {
      $result.normalizedValue = normalizedValue;
    }
    return $result;
  }
  SetParameterValueRequest._() : super();
  factory SetParameterValueRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetParameterValueRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, SetParameterValueRequest_NewValue>
      _SetParameterValueRequest_NewValueByTag = {
    3: SetParameterValueRequest_NewValue.textValue,
    4: SetParameterValueRequest_NewValue.normalizedValue,
    0: SetParameterValueRequest_NewValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetParameterValueRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'deviceInstanceId')
    ..aOS(2, _omitFieldNames ? '' : 'parameterId')
    ..aOS(3, _omitFieldNames ? '' : 'textValue')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'normalizedValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetParameterValueRequest clone() =>
      SetParameterValueRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetParameterValueRequest copyWith(
          void Function(SetParameterValueRequest) updates) =>
      super.copyWith((message) => updates(message as SetParameterValueRequest))
          as SetParameterValueRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetParameterValueRequest create() => SetParameterValueRequest._();
  SetParameterValueRequest createEmptyInstance() => create();
  static $pb.PbList<SetParameterValueRequest> createRepeated() =>
      $pb.PbList<SetParameterValueRequest>();
  @$core.pragma('dart2js:noInline')
  static SetParameterValueRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetParameterValueRequest>(create);
  static SetParameterValueRequest? _defaultInstance;

  SetParameterValueRequest_NewValue whichNewValue() =>
      _SetParameterValueRequest_NewValueByTag[$_whichOneof(0)]!;
  void clearNewValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get deviceInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstanceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get parameterId => $_getSZ(1);
  @$pb.TagNumber(2)
  set parameterId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasParameterId() => $_has(1);
  @$pb.TagNumber(2)
  void clearParameterId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get textValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set textValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTextValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTextValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get normalizedValue => $_getN(3);
  @$pb.TagNumber(4)
  set normalizedValue($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNormalizedValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearNormalizedValue() => $_clearField(4);
}

class SetParameterValueResponse extends $pb.GeneratedMessage {
  factory SetParameterValueResponse({
    DeviceInstance? deviceInstance,
  }) {
    final $result = create();
    if (deviceInstance != null) {
      $result.deviceInstance = deviceInstance;
    }
    return $result;
  }
  SetParameterValueResponse._() : super();
  factory SetParameterValueResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetParameterValueResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetParameterValueResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<DeviceInstance>(1, _omitFieldNames ? '' : 'deviceInstance',
        subBuilder: DeviceInstance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetParameterValueResponse clone() =>
      SetParameterValueResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetParameterValueResponse copyWith(
          void Function(SetParameterValueResponse) updates) =>
      super.copyWith((message) => updates(message as SetParameterValueResponse))
          as SetParameterValueResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetParameterValueResponse create() => SetParameterValueResponse._();
  SetParameterValueResponse createEmptyInstance() => create();
  static $pb.PbList<SetParameterValueResponse> createRepeated() =>
      $pb.PbList<SetParameterValueResponse>();
  @$core.pragma('dart2js:noInline')
  static SetParameterValueResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetParameterValueResponse>(create);
  static SetParameterValueResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DeviceInstance get deviceInstance => $_getN(0);
  @$pb.TagNumber(1)
  set deviceInstance(DeviceInstance v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstance() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstance() => $_clearField(1);
  @$pb.TagNumber(1)
  DeviceInstance ensureDeviceInstance() => $_ensure(0);
}

class BatchSetParameterValuesRequest extends $pb.GeneratedMessage {
  factory BatchSetParameterValuesRequest({
    $core.Iterable<SetParameterValueRequest>? requests,
  }) {
    final $result = create();
    if (requests != null) {
      $result.requests.addAll(requests);
    }
    return $result;
  }
  BatchSetParameterValuesRequest._() : super();
  factory BatchSetParameterValuesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchSetParameterValuesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchSetParameterValuesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pc<SetParameterValueRequest>(
        1, _omitFieldNames ? '' : 'requests', $pb.PbFieldType.PM,
        subBuilder: SetParameterValueRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchSetParameterValuesRequest clone() =>
      BatchSetParameterValuesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchSetParameterValuesRequest copyWith(
          void Function(BatchSetParameterValuesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as BatchSetParameterValuesRequest))
          as BatchSetParameterValuesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchSetParameterValuesRequest create() =>
      BatchSetParameterValuesRequest._();
  BatchSetParameterValuesRequest createEmptyInstance() => create();
  static $pb.PbList<BatchSetParameterValuesRequest> createRepeated() =>
      $pb.PbList<BatchSetParameterValuesRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchSetParameterValuesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchSetParameterValuesRequest>(create);
  static BatchSetParameterValuesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SetParameterValueRequest> get requests => $_getList(0);
}

class BatchSetParameterValuesResponse extends $pb.GeneratedMessage {
  factory BatchSetParameterValuesResponse({
    $core.Iterable<SetParameterValueResponse>? responses,
  }) {
    final $result = create();
    if (responses != null) {
      $result.responses.addAll(responses);
    }
    return $result;
  }
  BatchSetParameterValuesResponse._() : super();
  factory BatchSetParameterValuesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchSetParameterValuesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchSetParameterValuesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pc<SetParameterValueResponse>(
        1, _omitFieldNames ? '' : 'responses', $pb.PbFieldType.PM,
        subBuilder: SetParameterValueResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchSetParameterValuesResponse clone() =>
      BatchSetParameterValuesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchSetParameterValuesResponse copyWith(
          void Function(BatchSetParameterValuesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BatchSetParameterValuesResponse))
          as BatchSetParameterValuesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchSetParameterValuesResponse create() =>
      BatchSetParameterValuesResponse._();
  BatchSetParameterValuesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchSetParameterValuesResponse> createRepeated() =>
      $pb.PbList<BatchSetParameterValuesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchSetParameterValuesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchSetParameterValuesResponse>(
          create);
  static BatchSetParameterValuesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SetParameterValueResponse> get responses => $_getList(0);
}

class DeviceSpecificCommand extends $pb.GeneratedMessage {
  factory DeviceSpecificCommand({
    $core.String? type,
    $2.Struct? parameter,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (parameter != null) {
      $result.parameter = parameter;
    }
    return $result;
  }
  DeviceSpecificCommand._() : super();
  factory DeviceSpecificCommand.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceSpecificCommand.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceSpecificCommand',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOM<$2.Struct>(3, _omitFieldNames ? '' : 'parameter',
        subBuilder: $2.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceSpecificCommand clone() =>
      DeviceSpecificCommand()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceSpecificCommand copyWith(
          void Function(DeviceSpecificCommand) updates) =>
      super.copyWith((message) => updates(message as DeviceSpecificCommand))
          as DeviceSpecificCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceSpecificCommand create() => DeviceSpecificCommand._();
  DeviceSpecificCommand createEmptyInstance() => create();
  static $pb.PbList<DeviceSpecificCommand> createRepeated() =>
      $pb.PbList<DeviceSpecificCommand>();
  @$core.pragma('dart2js:noInline')
  static DeviceSpecificCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceSpecificCommand>(create);
  static DeviceSpecificCommand? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(2)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $2.Struct get parameter => $_getN(1);
  @$pb.TagNumber(3)
  set parameter($2.Struct v) {
    $_setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasParameter() => $_has(1);
  @$pb.TagNumber(3)
  void clearParameter() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.Struct ensureParameter() => $_ensure(1);
}

class ExecuteDeviceSpecificCommandRequest extends $pb.GeneratedMessage {
  factory ExecuteDeviceSpecificCommandRequest({
    $core.String? deviceInstanceId,
    DeviceSpecificCommand? command,
  }) {
    final $result = create();
    if (deviceInstanceId != null) {
      $result.deviceInstanceId = deviceInstanceId;
    }
    if (command != null) {
      $result.command = command;
    }
    return $result;
  }
  ExecuteDeviceSpecificCommandRequest._() : super();
  factory ExecuteDeviceSpecificCommandRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExecuteDeviceSpecificCommandRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecuteDeviceSpecificCommandRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceInstanceId')
    ..aOM<DeviceSpecificCommand>(2, _omitFieldNames ? '' : 'command',
        subBuilder: DeviceSpecificCommand.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExecuteDeviceSpecificCommandRequest clone() =>
      ExecuteDeviceSpecificCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExecuteDeviceSpecificCommandRequest copyWith(
          void Function(ExecuteDeviceSpecificCommandRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ExecuteDeviceSpecificCommandRequest))
          as ExecuteDeviceSpecificCommandRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecuteDeviceSpecificCommandRequest create() =>
      ExecuteDeviceSpecificCommandRequest._();
  ExecuteDeviceSpecificCommandRequest createEmptyInstance() => create();
  static $pb.PbList<ExecuteDeviceSpecificCommandRequest> createRepeated() =>
      $pb.PbList<ExecuteDeviceSpecificCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static ExecuteDeviceSpecificCommandRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ExecuteDeviceSpecificCommandRequest>(create);
  static ExecuteDeviceSpecificCommandRequest? _defaultInstance;

  /// コマンド実行対象の Device Instance の id
  @$pb.TagNumber(1)
  $core.String get deviceInstanceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceInstanceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceInstanceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceInstanceId() => $_clearField(1);

  @$pb.TagNumber(2)
  DeviceSpecificCommand get command => $_getN(1);
  @$pb.TagNumber(2)
  set command(DeviceSpecificCommand v) {
    $_setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCommand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommand() => $_clearField(2);
  @$pb.TagNumber(2)
  DeviceSpecificCommand ensureCommand() => $_ensure(1);
}

class ExecuteDeviceSpecificCommandResponse extends $pb.GeneratedMessage {
  factory ExecuteDeviceSpecificCommandResponse({
    $2.Struct? commandResult,
  }) {
    final $result = create();
    if (commandResult != null) {
      $result.commandResult = commandResult;
    }
    return $result;
  }
  ExecuteDeviceSpecificCommandResponse._() : super();
  factory ExecuteDeviceSpecificCommandResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExecuteDeviceSpecificCommandResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecuteDeviceSpecificCommandResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<$2.Struct>(1, _omitFieldNames ? '' : 'commandResult',
        subBuilder: $2.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExecuteDeviceSpecificCommandResponse clone() =>
      ExecuteDeviceSpecificCommandResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExecuteDeviceSpecificCommandResponse copyWith(
          void Function(ExecuteDeviceSpecificCommandResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ExecuteDeviceSpecificCommandResponse))
          as ExecuteDeviceSpecificCommandResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecuteDeviceSpecificCommandResponse create() =>
      ExecuteDeviceSpecificCommandResponse._();
  ExecuteDeviceSpecificCommandResponse createEmptyInstance() => create();
  static $pb.PbList<ExecuteDeviceSpecificCommandResponse> createRepeated() =>
      $pb.PbList<ExecuteDeviceSpecificCommandResponse>();
  @$core.pragma('dart2js:noInline')
  static ExecuteDeviceSpecificCommandResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ExecuteDeviceSpecificCommandResponse>(create);
  static ExecuteDeviceSpecificCommandResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Struct get commandResult => $_getN(0);
  @$pb.TagNumber(1)
  set commandResult($2.Struct v) {
    $_setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCommandResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommandResult() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Struct ensureCommandResult() => $_ensure(0);
}

///
/// 以下は ParameterSync の開始から終了までのシーケンス図。
/// AudioMixer のVolume フェーダーのドラッグフェーダーのによってパラメーターを操作するユースケースの例です。
///
/// ```mermaid
/// sequenceDiagram
/// autonumber
/// participant User
/// participant App
/// participant Engine
///
/// User->>App: AudioMixer を操作するページへ遷移
/// App->>Engine: StartParameterRequest（セッション ID を送る）
/// Engine->>App: Response
/// App->>User: AudioMixer のページを表示
///
/// rect rgba(173, 216, 230, 0.2)
/// note over App,Engine: UDP
/// User->>App: フェーダーのドラッグ
/// App->>Engine: Update コマンド（再送処理なし）
/// Engine->>App: RtParameter （UPDATING、変更がない場合も1秒に一回程度定期的に送信）
/// App->>User: フェーダーのインディケーター表示位置を更新
/// User->>App: フェーダーのドラッグ終了
///
/// App->>Engine: Finalize コマンド（ドラッグ終了時など。FINALIZED の state が帰ってこない場合再送）
/// Engine->>App: RtParameter（FINALIZED、変更がない場合も1秒に一回程度定期的に送信）
/// App->>User: フェーダーのインディケーター表示位置を更新
/// end
/// User->>App: AudioMixer のページ外へ遷移
/// App->>Engine: StopParameterSyncRequest
/// Engine->>App: Response
/// App->>User: 別ページを表示
///
/// ```
class StartParameterSyncRequest extends $pb.GeneratedMessage {
  factory StartParameterSyncRequest({
    $core.int? rtSessionId,
    $core.Iterable<$core.String>? parameterSyncKeys,
  }) {
    final $result = create();
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    if (parameterSyncKeys != null) {
      $result.parameterSyncKeys.addAll(parameterSyncKeys);
    }
    return $result;
  }
  StartParameterSyncRequest._() : super();
  factory StartParameterSyncRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartParameterSyncRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartParameterSyncRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..pPS(2, _omitFieldNames ? '' : 'parameterSyncKeys')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartParameterSyncRequest clone() =>
      StartParameterSyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartParameterSyncRequest copyWith(
          void Function(StartParameterSyncRequest) updates) =>
      super.copyWith((message) => updates(message as StartParameterSyncRequest))
          as StartParameterSyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartParameterSyncRequest create() => StartParameterSyncRequest._();
  StartParameterSyncRequest createEmptyInstance() => create();
  static $pb.PbList<StartParameterSyncRequest> createRepeated() =>
      $pb.PbList<StartParameterSyncRequest>();
  @$core.pragma('dart2js:noInline')
  static StartParameterSyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartParameterSyncRequest>(create);
  static StartParameterSyncRequest? _defaultInstance;

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

  ///  同期を開始したいパラメーターの parameter_sync_key を指定してください。
  ///
  ///  DeviceInstance リソースの、parameters.{parameter_id}.parameter_sync_key の値を用いてください。
  ///  フォーマットは変更の可能性があります。他のデータを合成して、key を生成しないでください。
  ///
  ///  例:
  ///   "fx324:cutoff"
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get parameterSyncKeys => $_getList(1);
}

class StartParameterSyncResponse extends $pb.GeneratedMessage {
  factory StartParameterSyncResponse() => create();
  StartParameterSyncResponse._() : super();
  factory StartParameterSyncResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StartParameterSyncResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartParameterSyncResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StartParameterSyncResponse clone() =>
      StartParameterSyncResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StartParameterSyncResponse copyWith(
          void Function(StartParameterSyncResponse) updates) =>
      super.copyWith(
              (message) => updates(message as StartParameterSyncResponse))
          as StartParameterSyncResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartParameterSyncResponse create() => StartParameterSyncResponse._();
  StartParameterSyncResponse createEmptyInstance() => create();
  static $pb.PbList<StartParameterSyncResponse> createRepeated() =>
      $pb.PbList<StartParameterSyncResponse>();
  @$core.pragma('dart2js:noInline')
  static StartParameterSyncResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartParameterSyncResponse>(create);
  static StartParameterSyncResponse? _defaultInstance;
}

class StopParameterSyncRequest extends $pb.GeneratedMessage {
  factory StopParameterSyncRequest({
    $core.int? rtSessionId,
    $core.Iterable<$core.String>? parameterSyncKeys,
  }) {
    final $result = create();
    if (rtSessionId != null) {
      $result.rtSessionId = rtSessionId;
    }
    if (parameterSyncKeys != null) {
      $result.parameterSyncKeys.addAll(parameterSyncKeys);
    }
    return $result;
  }
  StopParameterSyncRequest._() : super();
  factory StopParameterSyncRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopParameterSyncRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopParameterSyncRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'rtSessionId', $pb.PbFieldType.O3)
    ..pPS(2, _omitFieldNames ? '' : 'parameterSyncKeys')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopParameterSyncRequest clone() =>
      StopParameterSyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopParameterSyncRequest copyWith(
          void Function(StopParameterSyncRequest) updates) =>
      super.copyWith((message) => updates(message as StopParameterSyncRequest))
          as StopParameterSyncRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopParameterSyncRequest create() => StopParameterSyncRequest._();
  StopParameterSyncRequest createEmptyInstance() => create();
  static $pb.PbList<StopParameterSyncRequest> createRepeated() =>
      $pb.PbList<StopParameterSyncRequest>();
  @$core.pragma('dart2js:noInline')
  static StopParameterSyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopParameterSyncRequest>(create);
  static StopParameterSyncRequest? _defaultInstance;

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

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get parameterSyncKeys => $_getList(1);
}

class StopParameterSyncResponse extends $pb.GeneratedMessage {
  factory StopParameterSyncResponse() => create();
  StopParameterSyncResponse._() : super();
  factory StopParameterSyncResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory StopParameterSyncResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopParameterSyncResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  StopParameterSyncResponse clone() =>
      StopParameterSyncResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  StopParameterSyncResponse copyWith(
          void Function(StopParameterSyncResponse) updates) =>
      super.copyWith((message) => updates(message as StopParameterSyncResponse))
          as StopParameterSyncResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopParameterSyncResponse create() => StopParameterSyncResponse._();
  StopParameterSyncResponse createEmptyInstance() => create();
  static $pb.PbList<StopParameterSyncResponse> createRepeated() =>
      $pb.PbList<StopParameterSyncResponse>();
  @$core.pragma('dart2js:noInline')
  static StopParameterSyncResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopParameterSyncResponse>(create);
  static StopParameterSyncResponse? _defaultInstance;
}

enum RtUpdateParameterCommand_NewValue { textValue, normalizedValue, notSet }

/// 10秒間 Update がない場合、自動的に Finalize されます。
class RtUpdateParameterCommand extends $pb.GeneratedMessage {
  factory RtUpdateParameterCommand({
    $core.String? parameterSyncKey,
    $core.String? textValue,
    $core.double? normalizedValue,
  }) {
    final $result = create();
    if (parameterSyncKey != null) {
      $result.parameterSyncKey = parameterSyncKey;
    }
    if (textValue != null) {
      $result.textValue = textValue;
    }
    if (normalizedValue != null) {
      $result.normalizedValue = normalizedValue;
    }
    return $result;
  }
  RtUpdateParameterCommand._() : super();
  factory RtUpdateParameterCommand.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtUpdateParameterCommand.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RtUpdateParameterCommand_NewValue>
      _RtUpdateParameterCommand_NewValueByTag = {
    10: RtUpdateParameterCommand_NewValue.textValue,
    11: RtUpdateParameterCommand_NewValue.normalizedValue,
    0: RtUpdateParameterCommand_NewValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtUpdateParameterCommand',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [10, 11])
    ..aOS(1, _omitFieldNames ? '' : 'parameterSyncKey')
    ..aOS(10, _omitFieldNames ? '' : 'textValue')
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'normalizedValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtUpdateParameterCommand clone() =>
      RtUpdateParameterCommand()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtUpdateParameterCommand copyWith(
          void Function(RtUpdateParameterCommand) updates) =>
      super.copyWith((message) => updates(message as RtUpdateParameterCommand))
          as RtUpdateParameterCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtUpdateParameterCommand create() => RtUpdateParameterCommand._();
  RtUpdateParameterCommand createEmptyInstance() => create();
  static $pb.PbList<RtUpdateParameterCommand> createRepeated() =>
      $pb.PbList<RtUpdateParameterCommand>();
  @$core.pragma('dart2js:noInline')
  static RtUpdateParameterCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtUpdateParameterCommand>(create);
  static RtUpdateParameterCommand? _defaultInstance;

  RtUpdateParameterCommand_NewValue whichNewValue() =>
      _RtUpdateParameterCommand_NewValueByTag[$_whichOneof(0)]!;
  void clearNewValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get parameterSyncKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set parameterSyncKey($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParameterSyncKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearParameterSyncKey() => $_clearField(1);

  @$pb.TagNumber(10)
  $core.String get textValue => $_getSZ(1);
  @$pb.TagNumber(10)
  set textValue($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTextValue() => $_has(1);
  @$pb.TagNumber(10)
  void clearTextValue() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get normalizedValue => $_getN(2);
  @$pb.TagNumber(11)
  set normalizedValue($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasNormalizedValue() => $_has(2);
  @$pb.TagNumber(11)
  void clearNormalizedValue() => $_clearField(11);
}

enum RtFinalizeParameterCommand_NewValue { textValue, normalizedValue, notSet }

class RtFinalizeParameterCommand extends $pb.GeneratedMessage {
  factory RtFinalizeParameterCommand({
    $core.String? parameterSyncKey,
    $core.String? textValue,
    $core.double? normalizedValue,
  }) {
    final $result = create();
    if (parameterSyncKey != null) {
      $result.parameterSyncKey = parameterSyncKey;
    }
    if (textValue != null) {
      $result.textValue = textValue;
    }
    if (normalizedValue != null) {
      $result.normalizedValue = normalizedValue;
    }
    return $result;
  }
  RtFinalizeParameterCommand._() : super();
  factory RtFinalizeParameterCommand.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtFinalizeParameterCommand.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RtFinalizeParameterCommand_NewValue>
      _RtFinalizeParameterCommand_NewValueByTag = {
    10: RtFinalizeParameterCommand_NewValue.textValue,
    11: RtFinalizeParameterCommand_NewValue.normalizedValue,
    0: RtFinalizeParameterCommand_NewValue.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtFinalizeParameterCommand',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [10, 11])
    ..aOS(1, _omitFieldNames ? '' : 'parameterSyncKey')
    ..aOS(10, _omitFieldNames ? '' : 'textValue')
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'normalizedValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtFinalizeParameterCommand clone() =>
      RtFinalizeParameterCommand()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtFinalizeParameterCommand copyWith(
          void Function(RtFinalizeParameterCommand) updates) =>
      super.copyWith(
              (message) => updates(message as RtFinalizeParameterCommand))
          as RtFinalizeParameterCommand;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtFinalizeParameterCommand create() => RtFinalizeParameterCommand._();
  RtFinalizeParameterCommand createEmptyInstance() => create();
  static $pb.PbList<RtFinalizeParameterCommand> createRepeated() =>
      $pb.PbList<RtFinalizeParameterCommand>();
  @$core.pragma('dart2js:noInline')
  static RtFinalizeParameterCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtFinalizeParameterCommand>(create);
  static RtFinalizeParameterCommand? _defaultInstance;

  RtFinalizeParameterCommand_NewValue whichNewValue() =>
      _RtFinalizeParameterCommand_NewValueByTag[$_whichOneof(0)]!;
  void clearNewValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get parameterSyncKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set parameterSyncKey($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParameterSyncKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearParameterSyncKey() => $_clearField(1);

  @$pb.TagNumber(10)
  $core.String get textValue => $_getSZ(1);
  @$pb.TagNumber(10)
  set textValue($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTextValue() => $_has(1);
  @$pb.TagNumber(10)
  void clearTextValue() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get normalizedValue => $_getN(2);
  @$pb.TagNumber(11)
  set normalizedValue($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasNormalizedValue() => $_has(2);
  @$pb.TagNumber(11)
  void clearNormalizedValue() => $_clearField(11);
}

class RtParameter extends $pb.GeneratedMessage {
  factory RtParameter({
    $core.String? parameterSyncKey,
    $core.int? sequenceNumber,
    $core.String? textUnmodulatedValue,
    $core.double? normalizedUnmodulatedValue,
    $core.double? normalizedModulatedValue,
    RtParameter_State? state,
  }) {
    final $result = create();
    if (parameterSyncKey != null) {
      $result.parameterSyncKey = parameterSyncKey;
    }
    if (sequenceNumber != null) {
      $result.sequenceNumber = sequenceNumber;
    }
    if (textUnmodulatedValue != null) {
      $result.textUnmodulatedValue = textUnmodulatedValue;
    }
    if (normalizedUnmodulatedValue != null) {
      $result.normalizedUnmodulatedValue = normalizedUnmodulatedValue;
    }
    if (normalizedModulatedValue != null) {
      $result.normalizedModulatedValue = normalizedModulatedValue;
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  RtParameter._() : super();
  factory RtParameter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RtParameter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RtParameter',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parameterSyncKey')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'sequenceNumber', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'textUnmodulatedValue')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'normalizedUnmodulatedValue',
        $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'normalizedModulatedValue',
        $pb.PbFieldType.OD)
    ..e<RtParameter_State>(
        10, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: RtParameter_State.STATE_UNSPECIFIED,
        valueOf: RtParameter_State.valueOf,
        enumValues: RtParameter_State.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RtParameter clone() => RtParameter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RtParameter copyWith(void Function(RtParameter) updates) =>
      super.copyWith((message) => updates(message as RtParameter))
          as RtParameter;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RtParameter create() => RtParameter._();
  RtParameter createEmptyInstance() => create();
  static $pb.PbList<RtParameter> createRepeated() => $pb.PbList<RtParameter>();
  @$core.pragma('dart2js:noInline')
  static RtParameter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RtParameter>(create);
  static RtParameter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get parameterSyncKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set parameterSyncKey($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParameterSyncKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearParameterSyncKey() => $_clearField(1);

  /// Wrap-around
  @$pb.TagNumber(2)
  $core.int get sequenceNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set sequenceNumber($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSequenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceNumber() => $_clearField(2);

  /// CV Modulation 適用前の値。
  @$pb.TagNumber(3)
  $core.String get textUnmodulatedValue => $_getSZ(2);
  @$pb.TagNumber(3)
  set textUnmodulatedValue($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTextUnmodulatedValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTextUnmodulatedValue() => $_clearField(3);

  /// CV Modulation 適用前の値。
  @$pb.TagNumber(4)
  $core.double get normalizedUnmodulatedValue => $_getN(3);
  @$pb.TagNumber(4)
  set normalizedUnmodulatedValue($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNormalizedUnmodulatedValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearNormalizedUnmodulatedValue() => $_clearField(4);

  /// CV Modulation 適用後の値。
  @$pb.TagNumber(5)
  $core.double get normalizedModulatedValue => $_getN(4);
  @$pb.TagNumber(5)
  set normalizedModulatedValue($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasNormalizedModulatedValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearNormalizedModulatedValue() => $_clearField(5);

  @$pb.TagNumber(10)
  RtParameter_State get state => $_getN(5);
  @$pb.TagNumber(10)
  set state(RtParameter_State v) {
    $_setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasState() => $_has(5);
  @$pb.TagNumber(10)
  void clearState() => $_clearField(10);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
