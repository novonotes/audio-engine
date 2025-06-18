import 'dart:io';

import 'package:audio_engine/v1alpha1.dart';
import 'package:flutter_test/flutter_test.dart';

import '../example/cli/ffi_playback/main_v1alpha1.dart' as in_process_playback;
import '../example/cli/socket_playback/main_v1alpha1.dart'
    as out_process_playback;

void main() {
  AudioEngineConfig.logging = true;
  test(
    "In-process playback",
    () async {
      await in_process_playback.main();
    },
  );

  test(
    "Out-process playback",
    () async {
      // iOS は Out-process での利用をサポートしない
      if (Platform.isIOS) {
        return;
      }
      await out_process_playback.main();
    },
  );
}
