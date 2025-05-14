// ignore_for_file: avoid_print

import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:async';
import 'package:audio_engine/src/config.dart';
import 'package:audio_engine/src/in_process_engine/native_engine_bindings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart';

import 'package:audio_engine/test_utils.dart';
import 'utils.dart';

void main() {
  AudioEngineConfig.logging = true;
  group('NativeEngineBindings Integration Tests', () {
    NativeEngineBindings? bindings;
    String? dllPath;
    Timer? juceMessageTimer;

    setUpAll(() async {
      if (Platform.isIOS == false) {
        dllPath = await getAudioEngineLibraryPath();
        print("dllPath: $dllPath");
      }
    });

    setUp(() {
      print("pid: $pid");
      print("current time: ${DateTime.now().toIso8601String()}");
      print("dllPath: $dllPath");
      if (Platform.isIOS) {
        bindings = NativeEngineBindings.process();
      } else {
        bindings = NativeEngineBindings.open(dllPath!);
      }

      // Windows の場合のみ、FFI 側でメッセージループを回すように実装できていないので、
      // Dart 側で定期的に JUCE のメッセージを処理する必要がある。
      if (Platform.isWindows) {
        juceMessageTimer = startJuceMessageTimer(juceMessageTimer, bindings);
      }
    });

    tearDown(() async {
      juceMessageTimer?.cancel();
      bindings?.dispose();
    });

    test(
      'Full lifecycle test',
      () async {
        // 1. 初期化
        await bindings!.initDartApi();
        print("Dart API initialized.");

        // 2. メッセージマネージャーの初期化
        await bindings!.initMessageManager(0);
        print("Message Manager initialized.");

        // 3. エンジンの初期化
        final receivePort = ReceivePort();
        final dartPortId = receivePort.sendPort.nativePort;
        await bindings!.initEngine(dartPortId);
        print("Engine initialized.");

        final testMessage = Message.from(
          body: Uint8List(0),
          bodyType: 0,
          context: Uint8List(0),
          sessionId: 1,
        ).buffer;

        // 4. メッセージの送信
        await bindings!.sendMessageToEngine(testMessage);
        print("Message sent with success.");

        // 5. エンジンのシャットダウン
        await bindings!.shutdownEngine();
        print('Engine shutdown.');

        await bindings!.shutdownMessageManager();
        print('MessageManager shutdown.');

        // 6. Dart APIのシャットダウン
        await bindings!.shutdownDartApi();
        print('Dart API shutdown.');

        receivePort.close();
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );
  });
}
