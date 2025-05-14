// v1alpha1
import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class InvalidAudioRegionScenario implements Scenario {
  final e.TrackController trackController;
  final e.AudioRegionController regionController;

  InvalidAudioRegionScenario(this.trackController, this.regionController);

  static const name = "Adding Invalid Audio Region";

  @override
  Future<void> tearDown() async {}

  @override
  Future<void> run(ExpectFunc expect) async {
    const trackId = 'track-1';
    final res = await trackController.createTrack(e.CreateTrackRequest(
      track: e.Track(
        id: trackId,
        type: e.Track_TrackType.TRACK_TYPE_AUDIO,
      ),
    ));
    expect(res, isNot(""));

    try {
      await regionController.createAudioRegion(
        e.CreateAudioRegionRequest(
          parentId: trackId,
          audioRegion: e.AudioRegion(
            id: "region-1",
            sourceFilePath: "/invalid/path",
            position: 0,
            duration: 0,
          ),
        ),
      );
      fail("Threw nothing.");
    } catch (error) {
      expect(error, isA<e.NativeEngineError>());
      final errorMessage = error as e.NativeEngineError;
      expect(errorMessage.codeInt, 5);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  e.AudioEngineConfig.logging = true;
  final manager = e.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRootPath: "../../..");

    e.TrackController? trackController;
    e.AudioRegionController? regionController;
    try {
      final engine = await manager.startInProcessAudioEngine(dllPath);
      trackController = e.TrackController(engine.channel);
      regionController = e.AudioRegionController(engine.channel);
    } catch (e) {
      print("Failed to launch InProcessAudioEngine: $e");
      rethrow;
    }
    await runFullScenario(
        InvalidAudioRegionScenario(trackController, regionController));
  } finally {
    await manager.dispose();
  }
}
