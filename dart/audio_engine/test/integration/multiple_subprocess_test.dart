import 'dart:async';

import 'package:audio_engine/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart' as nam;
import 'package:nam/fs.dart' as fs;

import 'package:audio_engine/test_utils.dart';

void main() {
  group(
    'EngineControllerManager',
    () {
      AudioEngineConfig.logging = true;
      nam.enableLogging();
      var manager = EngineSessionManager();
      setUp(() async {
        manager = EngineSessionManager();
      });

      tearDown(() async {
        await manager.dispose();
      });

      test(
        "Start and stop two subprocess engines",
        () async {
          final file = await getUdsFile();
          await file.parent.create(recursive: true);
          if (fs.existsSync(file.path)) {
            fs.deleteSync(file.path);
          }
          await manager.startAcceptingOutProcessEngineUds(file.path);

          final executablePath = await getAudioEngineServiceExecutablePath();

          final engine1 =
              await manager.startSubprocessAudioEngine(executablePath);
          final engine2 =
              await manager.startSubprocessAudioEngine(executablePath);

          expect(engine1, isNot(engine2));
          expect(engine1.sessionId, isNot(engine2.sessionId));

          unawaited(manager.endSession(engine1.sessionId));
          await manager.sessionRemovedStream
              .firstWhere((instanceId) => instanceId == engine1.sessionId)
              .timeout(
                const Duration(seconds: 6),
                onTimeout: () =>
                    throw TimeoutException("Failed to remove engine 1."),
              );
          unawaited(manager.endSession(engine2.sessionId));
          await manager.sessionRemovedStream
              .firstWhere((instanceId) => instanceId == engine2.sessionId)
              .timeout(
                const Duration(seconds: 6),
                onTimeout: () =>
                    throw TimeoutException("Failed to remove engine 2."),
              );
        },
        timeout: const Timeout(Duration(seconds: 20)),
      );
    },
  );
}
