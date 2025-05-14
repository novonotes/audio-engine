import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/playhead_position_stream_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late PlayheadPositionStreamScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      scenario = PlayheadPositionStreamScenario(engine.channel);
    });

    tearDown(() async {
      await scenario.tearDown();
    });

    test("In-process: ${PlayheadPositionStreamScenario.name}", () async {
      await scenario.run(expect);
    });
  });
  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;

    PlayheadPositionStreamScenario? scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      scenario = PlayheadPositionStreamScenario(engine.channel);
    });

    tearDown(() async {
      await scenario?.tearDown();
    });

    test(
      "Out-process: ${PlayheadPositionStreamScenario.name}",
      () async {
        await scenario!.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
