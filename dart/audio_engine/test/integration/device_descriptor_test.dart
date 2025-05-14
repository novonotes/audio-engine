import 'package:audio_engine/foundation.dart';
import 'package:audio_engine/src/in_process_engine/in_process_engine.dart';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart';

import 'package:audio_engine/test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  AudioEngineConfig.logging = true;

  late InProcessEngine engine;
  late ae.DeviceDescriptorController controller;

  setUp(() async {
    engine = InProcessEngine(
      await getAudioEngineLibraryPath(),
      NamSessionManager(),
    );
    await engine.initialize();
    controller = ae.DeviceDescriptorController(engine);
  });

  tearDown(() async {
    await controller.dispose();
    await engine.dispose();
  });

  test('should list available device descriptors', () async {
    final response = await controller.listDeviceDescriptors(
      ae.ListDeviceDescriptorsRequest(),
    );

    // レスポンスの検証
    expect(response.deviceDescriptors.isNotEmpty, true,
        reason: 'Device descriptor list should not be empty');

    // 各デバイスディスクリプタの検証
    for (final descriptor in response.deviceDescriptors) {
      expect(descriptor.deviceTypeId.isNotEmpty, true,
          reason: 'deviceTypeId should not be empty');
      expect(descriptor.displayName.isNotEmpty, true,
          reason: 'displayName should not be empty');
      expect(descriptor.pluginFormatName.isNotEmpty, true,
          reason: 'pluginFormatName should not be empty');
      expect(descriptor.manufacturerName.isNotEmpty, true,
          reason: 'manufacturerName should not be empty');
      expect(descriptor.version.isNotEmpty, true,
          reason: 'version should not be empty');

      // デバッグ用の出力
      if (AudioEngineConfig.logging) {
        printDebug('Device: ${descriptor.displayName}');
        printDebug('  Type: ${descriptor.deviceTypeId}');
      }
    }
  });
}

void printDebug(String s) {
  // ignore: avoid_print
  print(s);
}
