import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audio_engine/src/platform/audio_engine_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAudioEngine platform = MethodChannelAudioEngine();
  const MethodChannel channel = MethodChannel('audio_engine');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == "getPlatformVersion") return '42';
        if (methodCall.method == "getTopLevelWindowHandle") return 8;
        throw UnsupportedError("Unsupported method: ${methodCall.method}");
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getTopLevelWindowHandle test', () async {
    final handle = await platform.getTopLevelWindowHandle();
    expect(handle, Platform.isWindows ? 8 : isNull);
  });
}
