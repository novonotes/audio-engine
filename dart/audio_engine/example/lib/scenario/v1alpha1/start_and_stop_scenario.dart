import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class StartAndStopScenario implements Scenario {
  final e.TransportController controller;

  StartAndStopScenario(this.controller);

  static const name = "Start And Stop Playback";

  @override
  Future<void> tearDown() async {}

  @override
  Future<void> run(ExpectFunc expect) async {
    await controller.startPlayback(e.StartPlaybackRequest());
    await controller.stopPlayback(e.StopPlaybackRequest());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  e.AudioEngineConfig.logging = true;
  final manager = e.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRootPath: "../../..");

    e.TransportController? transportController;
    try {
      final engine = await manager.startInProcessAudioEngine(dllPath);
      transportController = e.TransportController(engine.channel);
    } catch (error) {
      print("Failed to launch InProcessAudioEngine: $error");
      rethrow;
    }
    await runFullScenario(StartAndStopScenario(transportController));
  } finally {
    await manager.dispose();
  }
}
