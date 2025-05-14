import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

String _absoluteAndNormalizePath(String s) {
  return normalize(absolute(s));
}

Future<String> getAudioEngineLibraryPath({
  String audioEngineRootPath = "../..",
}) async {
  if (kDebugMode) {
    if (Platform.isMacOS) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineLibrary/Debug/libAudioEngine.so",
      ));
    }
    if (Platform.isLinux) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineLibrary/libAudioEngine.so",
      ));
    }
    if (Platform.isWindows) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineLibrary/Debug/AudioEngine.dll",
      ));
    }
    if (Platform.isIOS) {
      throw UnsupportedError("iOS is not supported.");
    }
  }
  // Release モードでどうするかは仕様未確定
  return _absoluteAndNormalizePath(
    "libAudioEngine.so",
  );
}

Future<String> getAudioEngineServiceExecutablePath({
  String audioEngineRootPath = "../..",
}) async {
  if (kDebugMode) {
    if (Platform.isMacOS) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/AudioEngineService",
      ));
    }
    if (Platform.isLinux) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/AudioEngineService",
      ));
    }
    if (Platform.isWindows) {
      return _absoluteAndNormalizePath(join(
        audioEngineRootPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/AudioEngineService.exe",
      ));
    }
  }
  // Release モードでどうするかは仕様未確定
  return _absoluteAndNormalizePath(
    "AudioEngineService",
  );
}
