import 'dart:async';

import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine/test_utils.dart' as e;

import '../../utils.dart';

Future<void> main() async {
  e.AudioEngineConfig.logging = true;
  final file = await e.getUdsFile();
  await file.parent.create(recursive: true);
  if (await file.exists()) {
    await file.delete();
  }
  final manager = e.EngineSessionManager();
  await manager.startAcceptingOutProcessEngineUds(file.path);

  unawaited(
    manager.startSubprocessAudioEngine(
        await e.getAudioEngineServiceExecutablePath()),
  );

  final engine = await manager.sessionAddedStream.first
      .timeout(const Duration(seconds: 10));

  print("Initialization finished.");

  // Track の追加
  final trackController = e.TrackController(engine.channel);
  const trackId = '123';
  await trackController.createTrack(e.CreateTrackRequest(
    track: e.Track(
      id: trackId,
      type: e.Track_TrackType.TRACK_TYPE_AUDIO,
    ),
  ));

  print("Track ID; $trackId");

  // Region の追加
  final regionController = e.AudioRegionController(engine.channel);
  final sourceFilePath = await getLocalAssetFilePath("assets/example.wav");
  final res2 =
      await regionController.createAudioRegion(e.CreateAudioRegionRequest(
    parentId: trackId,
    audioRegion: e.AudioRegion(
      id: "region-1",
      sourceFilePath: sourceFilePath,
      position: 0,
      duration: 32,
    ),
  ));
  print("Region ID; ${res2}");

  // Track を AudioInterface に Connect
  final connectionController = e.ConnectionController(engine.channel);
  await connectionController.connect(e.ConnectRequest(
    connection:
        e.Connection(srcAudioTrackId: trackId, destAudioOutput: e.Empty()),
  ));

  // 再生
  final transportController = e.TransportController(engine.channel);
  await transportController.updateTransport(e.UpdateTransportRequest(
    transport: e.Transport(playheadPosition: 0),
    updateMask: e.FieldMask(paths: ['playhead_position']),
  ));
  await transportController.startPlayback(e.StartPlaybackRequest());
  await Future<void>.delayed(const Duration(seconds: 4));
  await transportController.stopPlayback(e.StopPlaybackRequest());

  final managementController = e.EngineManagementController(engine.channel);
  await managementController.shutdown(e.ShutdownRequest());

  await manager.dispose();
}
