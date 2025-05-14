import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/device_state_restoration_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late DeviceStateRestorationScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      scenario = DeviceStateRestorationScenario(engine.channel);
    });

    tearDown(() async {
      await scenario.tearDown();
    });

    test("In-process: ${DeviceStateRestorationScenario.name}", () async {
      await scenario.run(expect);
    });
  });
  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;

    DeviceStateRestorationScenario? scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      scenario = DeviceStateRestorationScenario(engine.channel);
    });

    tearDown(() async {
      await scenario?.tearDown();
    });

    test(
      "Out-process: ${DeviceStateRestorationScenario.name}",
      () async {
        await scenario!.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
