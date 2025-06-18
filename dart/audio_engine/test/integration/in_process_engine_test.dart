import 'dart:typed_data';

import 'package:audio_engine/foundation.dart';
import 'package:audio_engine/src/in_process_engine/in_process_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart';

import 'package:audio_engine/test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  AudioEngineConfig.logging = true;

  /// 基本的な機能のテスト
  /// - エンジンの初期化ができる。
  /// - 無効な message を送ると、エラーメッセージが返ってくる。
  /// - エンジンの終了処理が正常に完了する。
  test("In-processs Engine", () async {
    final engine = InProcessEngine(
      await getAudioEngineLibraryPath(),
      NamSessionManager(),
    );

    await engine.initialize();

    // 無効なメッセージの送信。エラーが帰ってくるはず。
    engine.sendMessage(9999, Uint8List(0), Uint8List(0));

    bool errorRecieved = false;
    final sub = engine.receivedMessages.listen((mes) async {
      const errorMessageType = 1001;
      expect(mes.bodyType, errorMessageType);
      errorRecieved = true;
    });

    await engine.dispose();
    await sub.cancel();

    expect(errorRecieved, isTrue);
  });
}
