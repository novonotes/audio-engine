import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

String _absoluteAndNormalizePath(String s) {
  return normalize(absolute(s));
}

/// [audioEngineRepositoryPath] は novonotes/audio-engine リポジトリのルートディレクトリを指定します。
Future<String> getAudioEngineLibraryPath({
  String audioEngineRepositoryPath = "../..",
}) async {
  if (kDebugMode) {
    if (Platform.isMacOS) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineLibrary/Debug/libSonora.so",
      ));
    }
    if (Platform.isLinux) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineLibrary/libSonora.so",
      ));
    }
    if (Platform.isWindows) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineLibrary/Debug/Sonora.dll",
      ));
    }
    if (Platform.isIOS) {
      throw UnsupportedError("iOS is not supported.");
    }
  }
  // Release モードでどうするかは仕様未確定
  return _absoluteAndNormalizePath(
    "libSonora.so",
  );
}

Future<String> getAudioEngineServiceExecutablePath({
  String audioEngineRepositoryPath = "../..",
}) async {
  if (kDebugMode) {
    if (Platform.isMacOS) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/SonoraService",
      ));
    }
    if (Platform.isLinux) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/SonoraService",
      ));
    }
    if (Platform.isWindows) {
      return _absoluteAndNormalizePath(join(
        audioEngineRepositoryPath,
        "sonora/build/AudioEngineService/AudioEngineService_artefacts/Debug/SonoraService.exe",
      ));
    }
  }
  // Release モードでどうするかは仕様未確定
  return _absoluteAndNormalizePath(
    "SonoraService",
  );
}
