import 'dart:io';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

class CreateAndDeleteAudioTrackScenario implements Scenario {
  final ae.TrackController audioTrackController;
  final ae.AudioRegionController audioRegionController;
  final ae.ConnectionController connectionController;
  final ae.TransportController transportControlController;

  CreateAndDeleteAudioTrackScenario(
    ae.EngineMessageChannel channel,
  )   : audioTrackController = ae.TrackController(channel),
        audioRegionController = ae.AudioRegionController(channel),
        transportControlController = ae.TransportController(channel),
        connectionController = ae.ConnectionController(channel);

  static const name = "Create And Delete Audio Track";

  @override
  Future<void> tearDown() async {
    await audioTrackController.dispose();
    await audioRegionController.dispose();
    await connectionController.dispose();
  }

  @override
  Future<void> run(ExpectFunc expect) async {
    const audioTrackId = 'track-1';
    await audioTrackController.createTrack(ae.CreateTrackRequest(
      track: ae.Track(
        id: audioTrackId,
        type: ae.Track_TrackType.TRACK_TYPE_AUDIO,
      ),
    ));
    final sourceFilePath = absolute("../../../assets/example.wav");
    await audioRegionController.createAudioRegion(ae.CreateAudioRegionRequest(
        parentId: audioTrackId,
        audioRegion: ae.AudioRegion(
          id: 'region-1',
          sourceFilePath: sourceFilePath,
          position: 0,
          duration: null,
          gainDb: 0,
        )));
    await connectionController.connect(ae.ConnectRequest(
        connection: ae.Connection(
            srcAudioTrackId: audioTrackId, destAudioOutput: ae.Empty())));

    // // ここで Delete するので、再生しても音はでないはず。
    // // この delete のリクエストをコメントアウトすれば音が再生されるはず。
    // await audioTrackController.deleteTrack(ae.DeleteTrackRequest(
    //   trackId: audioTrackId,
    // ));

    await transportControlController.updateTransport(ae.UpdateTransportRequest(
      transport:
          ae.Transport(playheadPosition: 0.0, loopStart: 0, loopDuration: 1),
      updateMask: ae.FieldMask(
        paths: ['playhead_position', 'loop_start', 'loop_duration'],
      ),
    ));
    await transportControlController.startPlayback(ae.StartPlaybackRequest());
    await Future<void>.delayed(const Duration(seconds: 3));
    await transportControlController.stopPlayback(ae.StopPlaybackRequest());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ae.AudioEngineConfig.logging = true;
  print("CWD: ${Directory.current.path}");
  final manager = ae.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRepositoryPath: "../../..");

    ae.EngineSession? engine;
    try {
      engine = await manager.startInProcessAudioEngine(dllPath);
    } catch (e) {
      print("Failed to launch InProcessAudioEngine: $e");
      rethrow;
    }
    await runFullScenario(CreateAndDeleteAudioTrackScenario(engine.channel));
  } finally {
    await manager.dispose();
  }
}
