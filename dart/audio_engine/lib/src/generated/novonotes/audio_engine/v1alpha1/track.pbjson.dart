//
//  Generated code. Do not modify.
//  source: novonotes/audio_engine/v1alpha1/track.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use trackDescriptor instead')
const Track$json = {
  '1': 'Track',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.novonotes.audio_engine.v1alpha1.Track.TrackType',
      '8': {},
      '10': 'type'
    },
  ],
  '4': [Track_TrackType$json],
  '7': {},
};

@$core.Deprecated('Use trackDescriptor instead')
const Track_TrackType$json = {
  '1': 'TrackType',
  '2': [
    {'1': 'TRACK_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TRACK_TYPE_AUDIO', '2': 1},
    {'1': 'TRACK_TYPE_MIDI', '2': 2},
  ],
};

/// Descriptor for `Track`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackDescriptor = $convert.base64Decode(
    'CgVUcmFjaxIWCgJpZBgBIAEoCUIG4EEI4EECUgJpZBJJCgR0eXBlGAIgASgOMjAubm92b25vdG'
    'VzLmF1ZGlvX2VuZ2luZS52MWFscGhhMS5UcmFjay5UcmFja1R5cGVCA+BBAlIEdHlwZSJSCglU'
    'cmFja1R5cGUSGgoWVFJBQ0tfVFlQRV9VTlNQRUNJRklFRBAAEhQKEFRSQUNLX1RZUEVfQVVESU'
    '8QARITCg9UUkFDS19UWVBFX01JREkQAjoz6kEwCh9ub3Zvbm90ZXMvYXVkaW8tZW5naW4tYXBp'
    'L1RyYWNrKgZ0cmFja3MyBXRyYWNr');

@$core.Deprecated('Use createTrackRequestDescriptor instead')
const CreateTrackRequest$json = {
  '1': 'CreateTrackRequest',
  '2': [
    {
      '1': 'track',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.Track',
      '8': {},
      '10': 'track'
    },
  ],
};

/// Descriptor for `CreateTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTrackRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVUcmFja1JlcXVlc3QSQQoFdHJhY2sYASABKAsyJi5ub3Zvbm90ZXMuYXVkaW9fZW'
    '5naW5lLnYxYWxwaGExLlRyYWNrQgPgQQJSBXRyYWNr');

@$core.Deprecated('Use createTrackResponseDescriptor instead')
const CreateTrackResponse$json = {
  '1': 'CreateTrackResponse',
};

/// Descriptor for `CreateTrackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTrackResponseDescriptor =
    $convert.base64Decode('ChNDcmVhdGVUcmFja1Jlc3BvbnNl');

@$core.Deprecated('Use updateTrackRequestDescriptor instead')
const UpdateTrackRequest$json = {
  '1': 'UpdateTrackRequest',
  '2': [
    {
      '1': 'track',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.novonotes.audio_engine.v1alpha1.Track',
      '8': {},
      '10': 'track'
    },
  ],
};

/// Descriptor for `UpdateTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTrackRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVUcmFja1JlcXVlc3QSQQoFdHJhY2sYASABKAsyJi5ub3Zvbm90ZXMuYXVkaW9fZW'
    '5naW5lLnYxYWxwaGExLlRyYWNrQgPgQQJSBXRyYWNr');

@$core.Deprecated('Use updateTrackResponseDescriptor instead')
const UpdateTrackResponse$json = {
  '1': 'UpdateTrackResponse',
};

/// Descriptor for `UpdateTrackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTrackResponseDescriptor =
    $convert.base64Decode('ChNVcGRhdGVUcmFja1Jlc3BvbnNl');

@$core.Deprecated('Use deleteTrackRequestDescriptor instead')
const DeleteTrackRequest$json = {
  '1': 'DeleteTrackRequest',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'trackId'},
  ],
};

/// Descriptor for `DeleteTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTrackRequestDescriptor = $convert.base64Decode(
    'ChJEZWxldGVUcmFja1JlcXVlc3QSHgoIdHJhY2tfaWQYASABKAlCA+BBAlIHdHJhY2tJZA==');

@$core.Deprecated('Use deleteTrackResponseDescriptor instead')
const DeleteTrackResponse$json = {
  '1': 'DeleteTrackResponse',
};

/// Descriptor for `DeleteTrackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTrackResponseDescriptor =
    $convert.base64Decode('ChNEZWxldGVUcmFja1Jlc3BvbnNl');
