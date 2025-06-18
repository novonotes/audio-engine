// ignore_for_file: avoid_print

import 'dart:async';
import 'package:audio_engine/src/in_process_engine/native_engine_bindings.dart';
import 'package:flutter_test/flutter_test.dart';

Timer? startJuceMessageTimer(
    Timer? juceMessageTimer, NativeEngineBindings? bindings) {
  juceMessageTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
    final code = bindings!.dispatchNextJuceMessage();
    if (code != 0) {
      juceMessageTimer?.cancel();
      expect(
        code,
        equals(0),
        reason: "dispatchNextJuceMessage should return 0",
      );
    }
  });
  return juceMessageTimer;
}
