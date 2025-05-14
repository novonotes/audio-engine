//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/device_descriptor.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use deviceDescriptorDescriptor instead')
const DeviceDescriptor$json = {
  '1': 'DeviceDescriptor',
  '2': [
    {'1': 'device_type_id', '3': 1, '4': 1, '5': 9, '10': 'deviceTypeId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {
      '1': 'plugin_format_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '10': 'pluginFormatName'
    },
    {
      '1': 'manufacturer_name',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'manufacturerName'
    },
    {'1': 'version', '3': 6, '4': 1, '5': 9, '10': 'version'},
  ],
  '7': {},
};

/// Descriptor for `DeviceDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDescriptorDescriptor = $convert.base64Decode(
    'ChBEZXZpY2VEZXNjcmlwdG9yEiQKDmRldmljZV90eXBlX2lkGAEgASgJUgxkZXZpY2VUeXBlSW'
    'QSIQoMZGlzcGxheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIsChJwbHVnaW5fZm9ybWF0X25h'
    'bWUYAyABKAlSEHBsdWdpbkZvcm1hdE5hbWUSKwoRbWFudWZhY3R1cmVyX25hbWUYBSABKAlSEG'
    '1hbnVmYWN0dXJlck5hbWUSGAoHdmVyc2lvbhgGIAEoCVIHdmVyc2lvbjpR6kFOCidub3Zvbm90'
    'ZXMtYXVkaW8tZW5naW5lL0RldmljZURlc2NyaXB0b3IqEWRldmljZURlc2NyaXB0b3JzMhBkZX'
    'ZpY2VEZXNjcmlwdG9y');

@$core.Deprecated('Use listDeviceDescriptorsRequestDescriptor instead')
const ListDeviceDescriptorsRequest$json = {
  '1': 'ListDeviceDescriptorsRequest',
};

/// Descriptor for `ListDeviceDescriptorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDeviceDescriptorsRequestDescriptor =
    $convert.base64Decode('ChxMaXN0RGV2aWNlRGVzY3JpcHRvcnNSZXF1ZXN0');

@$core.Deprecated('Use listDeviceDescriptorsResponseDescriptor instead')
const ListDeviceDescriptorsResponse$json = {
  '1': 'ListDeviceDescriptorsResponse',
  '2': [
    {
      '1': 'device_descriptors',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.DeviceDescriptor',
      '10': 'deviceDescriptors'
    },
  ],
};

/// Descriptor for `ListDeviceDescriptorsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDeviceDescriptorsResponseDescriptor =
    $convert.base64Decode(
        'Ch1MaXN0RGV2aWNlRGVzY3JpcHRvcnNSZXNwb25zZRJgChJkZXZpY2VfZGVzY3JpcHRvcnMYAS'
        'ADKAsyMS5ub3Zvbm90ZXMuYXVkaW9fZW5naW5lLnYxYWxwaGExLkRldmljZURlc2NyaXB0b3JS'
        'EWRldmljZURlc2NyaXB0b3Jz');
