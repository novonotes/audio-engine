import 'dart:io';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class DebugStateScenario implements Scenario {
  final e.DebugUtilityController controller;

  DebugStateScenario(this.controller);

  static const name = "Get And Print Debug State";

  @override
  Future<void> tearDown() async {}

  @override
  Future<void> run(ExpectFunc expect) async {
    final res = await controller.debugState(e.DebugStateRequest());
    expect(res.state, isNotEmpty);
    print(res.state);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  e.AudioEngineConfig.logging = true;
  print("CWD: ${Directory.current.path}");
  final manager = e.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRepositoryPath: "../../..");

    e.EngineSession? engine;
    try {
      engine = await manager.startInProcessAudioEngine(dllPath);
    } catch (error) {
      print("Failed to launch InProcessAudioEngine: $error");
      rethrow;
    }
    final controller = e.DebugUtilityController(engine.channel);
    await runFullScenario(DebugStateScenario(controller));

    await controller.dispose();
  } finally {
    await manager.dispose();
  }
}
