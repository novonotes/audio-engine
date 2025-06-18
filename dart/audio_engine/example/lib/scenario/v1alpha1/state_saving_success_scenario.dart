import 'dart:io';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class StateSavingSuccessScenario implements Scenario {
  // あってる？
  final e.DebugUtilityController controller;

  StateSavingSuccessScenario(this.controller);

  static const name = "State Saving Success";

  final file = File("save_state_v1alpha1/test.tracktionedit");

  @override
  Future<void> tearDown() async {
    if (await file.parent.exists()) {
      await file.parent.delete(recursive: true);
    }
  }

  @override
  Future<void> run(ExpectFunc expect) async {
    // 実際にファイルを作成できるか確認
    if (await file.parent.exists()) {
      await file.parent.delete(recursive: true);
    }

    expect(await file.exists(), isFalse);
    expect(await file.parent.exists(), isFalse);

    await controller.saveState(e.SaveStateRequest(
      destFilePath: file.absolute.path,
    ));

    // 中間フォルダも作成されるはず
    expect(await file.parent.exists(), isTrue);

    // ファイルが作成されるはず
    expect(await file.exists(), isTrue);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final manager = e.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRepositoryPath: "../../..");

    e.DebugUtilityController? debugUtilityController;
    try {
      final engine = await manager.startInProcessAudioEngine(dllPath);
      debugUtilityController = e.DebugUtilityController(engine.channel);
    } catch (error) {
      print("Failed to launch InProcessAudioEngine: $error");
      rethrow;
    }
    await runFullScenario(StateSavingSuccessScenario(debugUtilityController));
  } finally {
    await manager.dispose();
  }
}
