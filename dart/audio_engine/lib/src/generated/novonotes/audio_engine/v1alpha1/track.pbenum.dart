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

class Track_TrackType extends $pb.ProtobufEnum {
  static const Track_TrackType TRACK_TYPE_UNSPECIFIED =
      Track_TrackType._(0, _omitEnumNames ? '' : 'TRACK_TYPE_UNSPECIFIED');
  static const Track_TrackType TRACK_TYPE_AUDIO =
      Track_TrackType._(1, _omitEnumNames ? '' : 'TRACK_TYPE_AUDIO');
  static const Track_TrackType TRACK_TYPE_MIDI =
      Track_TrackType._(2, _omitEnumNames ? '' : 'TRACK_TYPE_MIDI');

  static const $core.List<Track_TrackType> values = <Track_TrackType>[
    TRACK_TYPE_UNSPECIFIED,
    TRACK_TYPE_AUDIO,
    TRACK_TYPE_MIDI,
  ];

  static final $core.Map<$core.int, Track_TrackType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Track_TrackType? valueOf($core.int value) => _byValue[value];

  const Track_TrackType._(super.v, super.n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
