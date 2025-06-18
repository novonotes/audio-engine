import 'dart:io';
import 'dart:core';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:nam/nam.dart' as nam;

void main() {
  nam.enableLogging();
  e.AudioEngineConfig.logging = true;
  final manager = e.EngineSessionManager();

  tearDown(() async {
    await manager.dispose();
  });

  test(
    "Single Service Playback Test",
    () async {
      final executablePath = await getAudioEngineServiceExecutablePath();
      final sockPath = join(
        Directory.systemTemp.path,
        "novonotes",
        "single_service_playback.sock",
      );
      await manager.startAcceptingOutProcessEngineUds(sockPath);

      final engine1 = await manager.startSubprocessAudioEngine(executablePath);

      await playExample(engine1.channel);
    },
  );
}

Future<void> playExample(e.EngineMessageChannel channel) async {
  final trackController = e.TrackController(channel);
  final regionController = e.AudioRegionController(channel);
  final connectionController = e.ConnectionController(channel);
  final transportController = e.TransportController(channel);

  await trackController.createTrack(e.CreateTrackRequest(
    track: e.Track(
      id: 'track-1',
      type: e.Track_TrackType.TRACK_TYPE_AUDIO,
    ),
  ));

  final sourceFilePath = absolute("../../assets/example.wav");
  await regionController.createAudioRegion(e.CreateAudioRegionRequest(
    parentId: 'track-1',
    audioRegion: e.AudioRegion(
      id: 'region1',
      sourceFilePath: sourceFilePath,
      gainDb: 0,
      position: 0,
      duration: 32,
    ),
  ));
  await connectionController.connect(e.ConnectRequest(
    connection: e.Connection(
      srcAudioTrackId: 'track-1',
      destAudioOutput: e.Empty(),
    ),
  ));
  await transportController.updateTransport(e.UpdateTransportRequest(
    transport: e.Transport(playheadPosition: 0),
    updateMask: e.FieldMask(
      paths: ['playhead_position'],
    ),
  ));
  await transportController.startPlayback(e.StartPlaybackRequest());
  await Future<void>.delayed(const Duration(seconds: 4));
  await transportController.stopPlayback(e.StopPlaybackRequest());
}
