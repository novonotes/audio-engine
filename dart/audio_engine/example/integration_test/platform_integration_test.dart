import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:audio_engine/src/platform/audio_engine_platform_interface.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('getPlatformVersion test', () async {
    final String? version =
        await AudioEnginePlatform.instance.getPlatformVersion();
    // The version string depends on the host platform running the test, so
    // just assert that some non-empty string is returned.
    expect(version?.isNotEmpty, true);
  });

  test('getTopLevelWindowHandle test', () async {
    final int? windowHandle =
        await AudioEnginePlatform.instance.getTopLevelWindowHandle();

    if (!Platform.isWindows) {
      expect(windowHandle, isNull);
      return;
    }
    expect(windowHandle, isNotNull);
    expect(windowHandle, isNot(isZero));
  });
}
