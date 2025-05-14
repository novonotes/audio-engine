import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class StateSavingFailureScenario implements Scenario {
  final e.DebugUtilityController controller;

  StateSavingFailureScenario(this.controller);

  static const name = "State Saving Failure";

  @override
  Future<void> tearDown() async {}

  @override
  Future<void> run(ExpectFunc expect) async {
    // 空の destFilePath だと Error
    try {
      final _ =
          await controller.saveState(e.SaveStateRequest(destFilePath: ""));
      fail("Threw nothing.");
    } catch (error) {
      expect(error, isA<e.NativeEngineError>());
      final engineError = error as e.NativeEngineError;
      // Todo: 期待されるエラーコードに変更する？
      expect(engineError.codeInt, 2);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final manager = e.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRootPath: "../../..");

    e.DebugUtilityController? debugUtilityController;
    try {
      final engine = await manager.startInProcessAudioEngine(dllPath);
      debugUtilityController = e.DebugUtilityController(engine.channel);
    } catch (error) {
      print("Failed to launch InProcessAudioEngine: $error");
      rethrow;
    }
    await runFullScenario(StateSavingFailureScenario(debugUtilityController));
  } finally {
    await manager.dispose();
  }
}
