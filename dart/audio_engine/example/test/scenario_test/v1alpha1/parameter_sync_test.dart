import 'dart:io';

import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:audio_engine_example/scenario/v1alpha1/parameter_sync_scenario.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("In-process Engine Scenario: ", () {
    late ParameterSyncScenario scenario;

    setUp(() async {
      final engine = await setUpInProcessAudioEngine();
      scenario = ParameterSyncScenario(engine.channel);
    });

    tearDown(() async {
      await scenario.tearDown();
    });

    test("In-process: ${ParameterSyncScenario.name}", () async {
      await scenario.run(expect);
    });
  });

  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;
    e.AudioEngineConfig.logging = engineDebugMode;

    ParameterSyncScenario? scenario;

    setUp(() async {
      final engine =
          await setUpAudioEngineService(engineDebugMode: engineDebugMode);
      scenario = ParameterSyncScenario(engine.channel);
    });

    tearDown(() async {
      await scenario?.tearDown();
    });

    test(
      "Out-process: ${ParameterSyncScenario.name}",
      () async {
        await scenario!.run(expect);
      },
      // ignore: dead_code
      timeout: const Timeout(Duration(seconds: engineDebugMode ? 6000 : 30)),
      // Windows では失敗する。UDS から TCP に移行した方が良さそう。
      skip: Platform.isWindows,
    );
  });
}
