import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/start_and_stop_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late e.TransportController transportController;
    late StartAndStopScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      transportController = e.TransportController(engine.channel);
      scenario = StartAndStopScenario(transportController);
    });

    tearDown(() async {
      await scenario.tearDown();
      await transportController.dispose();
    });

    test("In-process: ${StartAndStopScenario.name}", () async {
      await scenario.run(expect);
    });
  });

  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;
    late e.TransportController transportController;
    late StartAndStopScenario scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      transportController = e.TransportController(engine.channel);
      scenario = StartAndStopScenario(transportController);
    });

    tearDown(() async {
      await scenario.tearDown();
      await transportController.dispose();
    });

    test(
      "Out-process: ${StartAndStopScenario.name}",
      () async {
        await scenario.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
