import 'dart:io';

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
    "Multiple Service Playback Test",
    () async {
      final executablePath = await getAudioEngineServiceExecutablePath();
      final sockPath = join(
        Directory.systemTemp.path,
        "novonotes",
        "multiple_service_playback.sock",
      );
      await manager.startAcceptingOutProcessEngineUds(sockPath);

      final [engine1, engine2, engine3] = await Future.wait([
        manager.startSubprocessAudioEngine(executablePath),
        manager.startSubprocessAudioEngine(executablePath),
        manager.startSubprocessAudioEngine(executablePath),
      ]);

      await Future.wait([
        playExample(engine1.channel, 0),
        playExample(engine2.channel, 100),
        playExample(engine3.channel, 200),
      ]);
    },
    // Windows の CI で不安定のため skip。原因未調査。
    skip: Platform.isWindows,
  );
}

Future<void> playExample(e.EngineMessageChannel channel, int delayMs) async {
  await Future<void>.delayed(Duration(milliseconds: delayMs));

  final trackController = e.TrackController(channel);
  final regionController = e.AudioRegionController(channel);
  final connectionController = e.ConnectionController(channel);
  final transportController = e.TransportController(channel);

  const trackId = 'track1';

  await trackController.createTrack(e.CreateTrackRequest(
    track: e.Track(
      id: trackId,
      type: e.Track_TrackType.TRACK_TYPE_AUDIO,
    ),
  ));

  final sourceFilePath = absolute("../../assets/example.wav");
  await regionController.createAudioRegion(e.CreateAudioRegionRequest(
    parentId: trackId,
    audioRegion: e.AudioRegion(
      id: 'region1',
      sourceFilePath: sourceFilePath,
      position: 0,
      duration: 32,
    ),
  ));

  await connectionController.connect(e.ConnectRequest(
    connection: e.Connection(
      srcAudioTrackId: trackId,
      destAudioOutput: e.Empty(),
    ),
  ));

  await transportController.updateTransport(e.UpdateTransportRequest(
    transport: e.Transport(playheadPosition: 0),
    updateMask: e.FieldMask(paths: ['playhead_position']),
  ));
  await transportController.startPlayback(e.StartPlaybackRequest());
  await Future<void>.delayed(const Duration(seconds: 4));
  await transportController.stopPlayback(e.StopPlaybackRequest());
}
