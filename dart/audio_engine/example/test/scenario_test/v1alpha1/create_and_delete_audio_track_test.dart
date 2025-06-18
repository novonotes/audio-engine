import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/create_and_delete_audio_track_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late CreateAndDeleteAudioTrackScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      scenario = CreateAndDeleteAudioTrackScenario(engine.channel);
    });

    tearDown(() async {
      await scenario.tearDown();
    });

    test("In-process: ${CreateAndDeleteAudioTrackScenario.name}", () async {
      await scenario.run(expect);
    });
  });
  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;

    CreateAndDeleteAudioTrackScenario? scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      scenario = CreateAndDeleteAudioTrackScenario(engine.channel);
    });

    tearDown(() async {
      await scenario?.tearDown();
    });

    test(
      "Out-process: ${CreateAndDeleteAudioTrackScenario.name}",
      () async {
        await scenario!.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
    );
  });
}
