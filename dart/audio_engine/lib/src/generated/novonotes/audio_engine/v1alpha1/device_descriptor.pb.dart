//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/device_descriptor.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class DeviceDescriptor extends $pb.GeneratedMessage {
  factory DeviceDescriptor({
    $core.String? deviceTypeId,
    $core.String? displayName,
    $core.String? pluginFormatName,
    $core.String? manufacturerName,
    $core.String? version,
  }) {
    final $result = create();
    if (deviceTypeId != null) {
      $result.deviceTypeId = deviceTypeId;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (pluginFormatName != null) {
      $result.pluginFormatName = pluginFormatName;
    }
    if (manufacturerName != null) {
      $result.manufacturerName = manufacturerName;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  DeviceDescriptor._() : super();
  factory DeviceDescriptor.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeviceDescriptor.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeviceDescriptor',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceTypeId')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'pluginFormatName')
    ..aOS(5, _omitFieldNames ? '' : 'manufacturerName')
    ..aOS(6, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeviceDescriptor clone() => DeviceDescriptor()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeviceDescriptor copyWith(void Function(DeviceDescriptor) updates) =>
      super.copyWith((message) => updates(message as DeviceDescriptor))
          as DeviceDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceDescriptor create() => DeviceDescriptor._();
  DeviceDescriptor createEmptyInstance() => create();
  static $pb.PbList<DeviceDescriptor> createRepeated() =>
      $pb.PbList<DeviceDescriptor>();
  @$core.pragma('dart2js:noInline')
  static DeviceDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeviceDescriptor>(create);
  static DeviceDescriptor? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceTypeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceTypeId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceTypeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceTypeId() => $_clearField(1);

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
  $core.String get pluginFormatName => $_getSZ(2);
  @$pb.TagNumber(3)
  set pluginFormatName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPluginFormatName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPluginFormatName() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.String get manufacturerName => $_getSZ(3);
  @$pb.TagNumber(5)
  set manufacturerName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasManufacturerName() => $_has(3);
  @$pb.TagNumber(5)
  void clearManufacturerName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get version => $_getSZ(4);
  @$pb.TagNumber(6)
  set version($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
}

class ListDeviceDescriptorsRequest extends $pb.GeneratedMessage {
  factory ListDeviceDescriptorsRequest() => create();
  ListDeviceDescriptorsRequest._() : super();
  factory ListDeviceDescriptorsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListDeviceDescriptorsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDeviceDescriptorsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListDeviceDescriptorsRequest clone() =>
      ListDeviceDescriptorsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListDeviceDescriptorsRequest copyWith(
          void Function(ListDeviceDescriptorsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListDeviceDescriptorsRequest))
          as ListDeviceDescriptorsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDeviceDescriptorsRequest create() =>
      ListDeviceDescriptorsRequest._();
  ListDeviceDescriptorsRequest createEmptyInstance() => create();
  static $pb.PbList<ListDeviceDescriptorsRequest> createRepeated() =>
      $pb.PbList<ListDeviceDescriptorsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListDeviceDescriptorsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDeviceDescriptorsRequest>(create);
  static ListDeviceDescriptorsRequest? _defaultInstance;
}

class ListDeviceDescriptorsResponse extends $pb.GeneratedMessage {
  factory ListDeviceDescriptorsResponse({
    $core.Iterable<DeviceDescriptor>? deviceDescriptors,
  }) {
    final $result = create();
    if (deviceDescriptors != null) {
      $result.deviceDescriptors.addAll(deviceDescriptors);
    }
    return $result;
  }
  ListDeviceDescriptorsResponse._() : super();
  factory ListDeviceDescriptorsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListDeviceDescriptorsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDeviceDescriptorsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'novonotes.audio_engine.v1alpha1'),
      createEmptyInstance: create)
    ..pc<DeviceDescriptor>(
        1, _omitFieldNames ? '' : 'deviceDescriptors', $pb.PbFieldType.PM,
        subBuilder: DeviceDescriptor.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListDeviceDescriptorsResponse clone() =>
      ListDeviceDescriptorsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListDeviceDescriptorsResponse copyWith(
          void Function(ListDeviceDescriptorsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListDeviceDescriptorsResponse))
          as ListDeviceDescriptorsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDeviceDescriptorsResponse create() =>
      ListDeviceDescriptorsResponse._();
  ListDeviceDescriptorsResponse createEmptyInstance() => create();
  static $pb.PbList<ListDeviceDescriptorsResponse> createRepeated() =>
      $pb.PbList<ListDeviceDescriptorsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListDeviceDescriptorsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDeviceDescriptorsResponse>(create);
  static ListDeviceDescriptorsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DeviceDescriptor> get deviceDescriptors => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
