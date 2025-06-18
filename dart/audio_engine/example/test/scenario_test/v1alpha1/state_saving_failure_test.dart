import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/state_saving_failure_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late e.DebugUtilityController debugUtilityController;
    late StateSavingFailureScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      debugUtilityController = e.DebugUtilityController(engine.channel);
      scenario = StateSavingFailureScenario(debugUtilityController);
    });

    tearDown(() async {
      await scenario.tearDown();
      await debugUtilityController.dispose();
    });

    test("In-process: ${StateSavingFailureScenario.name}", () async {
      await scenario.run(expect);
    });
  });

  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;
    late e.DebugUtilityController debugUtilityController;
    late StateSavingFailureScenario scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      debugUtilityController = e.DebugUtilityController(engine.channel);
      scenario = StateSavingFailureScenario(debugUtilityController);
    });

    tearDown(() async {
      await scenario.tearDown();
      await debugUtilityController.dispose();
    });

    test(
      "Out-process: ${StateSavingFailureScenario.name}",
      () async {
        await scenario.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
