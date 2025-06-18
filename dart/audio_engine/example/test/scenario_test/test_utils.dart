import 'dart:async';

import 'package:audio_engine/foundation.dart';
import 'package:audio_engine/test_utils.dart';
import 'package:flutter_test/flutter_test.dart';

Future<EngineSession> setUpInProcessAudioEngine() async {
  final manager = EngineSessionManager();

  addTearDown(() async {
    await manager.dispose();
  });
  final dllPath =
      await getAudioEngineLibraryPath(audioEngineRepositoryPath: "../../..");

  try {
    final engine = await manager.startInProcessAudioEngine(dllPath);
    return engine;
  } catch (e) {
    print("Failed to launch InProcessAudioEngine: $e");
    rethrow;
  }
}

Future<EngineSession> setUpAudioEngineService({
  required bool engineDebugMode,
}) async {
  final manager = EngineSessionManager();
  addTearDown(() async {
    await manager.dispose();
  });

  // UDS サーバーの起動
  {
    final file = await getUdsFile();
    await manager.startAcceptingOutProcessEngineUds(file.path);
  }

  // Audio Engine Service のプロセスを起動
  try {
    final executablePath = await getAudioEngineServiceExecutablePath(
      audioEngineRepositoryPath: "../../..",
    );
    if (!engineDebugMode) {
      unawaited(manager.startSubprocessAudioEngine(executablePath));
    }
    // 最初に接続された Audio Engine のクライアントをテストに用いる。
    final engine = await manager.sessionAddedStream.first.timeout(
      Duration(seconds: engineDebugMode ? 300 : 20),
      onTimeout: () => throw TimeoutException("No engine client connected."),
    );
    return engine;
  } catch (e) {
    print("Failed to launch Audio Engine Service: $e");
    rethrow;
  }
}
