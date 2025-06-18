// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:audio_engine/foundation.dart';
import 'package:audio_engine/src/in_process_engine/constants/status_code.dart';
import 'package:audio_engine/src/in_process_engine/native_engine_bindings.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:audio_engine/test_utils.dart';
import 'utils.dart';

void main() {
  AudioEngineConfig.logging = true;
  group(
    'NativeEngineBindings Integration Tests',
    () {
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

      test('Init and shutdown Engine', () async {
        final receivePort = ReceivePort();
        await bindings!.initDartApi();
        await bindings!.initMessageManager(0);
        await bindings!.initEngine(receivePort.sendPort.nativePort);
        await bindings?.shutdownEngine();
        await bindings?.shutdownMessageManager();
        await bindings?.shutdownDartApi();
      });

      test('Multiple initializations should not be allowed.', () async {
        try {
          await bindings!.initDartApi();
          await bindings!.initDartApi();
          fail("Threw nothing.");
        } catch (e) {
          expect(e, isA<NativeEngineBindingsException>());
          e as NativeEngineBindingsException;
          expect(e.statusCode, StatusCodes.DART_API_ALREADY_INITIALIZED);
        }
      });

      test('Send message without initialization', () async {
        final testMessage =
            Uint8List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        try {
          await bindings!.sendMessageToEngine(testMessage);
          fail("Threw nothing.");
        } catch (e) {
          expect(e, isA<NativeEngineBindingsException>());
          e as NativeEngineBindingsException;
          expect(e.statusCode, StatusCodes.ENGINE_NOT_RUNNING);
        }
      });

      test('Send message with invalid format', () async {
        final testMessage = Uint8List.fromList([1, 2, 3, 4, 5]);
        try {
          await bindings!.sendMessageToEngine(testMessage);
          fail("Threw nothing.");
        } catch (e) {
          expect(e, isA<NativeEngineBindingsException>());
          e as NativeEngineBindingsException;
          expect(e.statusCode, StatusCodes.INVALID_MESSAGE_FORMAT);
        }
      });

      test('Shutdown without initialization', () async {
        try {
          await bindings!.shutdownDartApi();
          fail("Threw nothing.");
        } catch (e) {
          expect(e, isA<NativeEngineBindingsException>());
          e as NativeEngineBindingsException;
          expect(e.statusCode, StatusCodes.MESSAGE_MANAGER_NOT_SHUT_DOWN);
        }
      });
    },
  );
}
