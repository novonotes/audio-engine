import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:flutter_test/flutter_test.dart';

import 'package:audio_engine_example/scenario/v1alpha1/invalid_audio_region_scenario.dart';
import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late e.TrackController trackController;
    late e.AudioRegionController regionController;
    late InvalidAudioRegionScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      trackController = e.TrackController(engine.channel);
      regionController = e.AudioRegionController(engine.channel);
      scenario = InvalidAudioRegionScenario(trackController, regionController);
    });
    tearDown(() async {
      await scenario.tearDown();
      await trackController.dispose();
      await regionController.dispose();
    });

    test("In-process: ${InvalidAudioRegionScenario.name}", () async {
      await scenario.run(expect);
    });
  });

  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;
    late e.TrackController trackController;
    late e.AudioRegionController regionController;
    late InvalidAudioRegionScenario scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      trackController = e.TrackController(engine.channel);
      regionController = e.AudioRegionController(engine.channel);
      scenario = InvalidAudioRegionScenario(trackController, regionController);
    });

    tearDown(() async {
      await scenario.tearDown();
      await trackController.dispose();
      await regionController.dispose();
    });

    test(
      "Out-process: ${InvalidAudioRegionScenario.name}",
      () async {
        await scenario.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
