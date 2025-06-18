import 'dart:async';
import 'package:audio_engine/src/logger.dart';
import 'package:audio_engine/src/in_process_engine/native_engine_bindings.dart';

/// Platform の Message Loop が利用できない場合に、
/// Dart 側のメインアイソーレートで、Timer のような仕組みで JUCE の MessageManager を駆動するためのクラス。
///
/// 現在までにこのクラスが必要になったのは、Windows の test で InProcessAudioEngine のライブラリを使うシナリオだけ。
class JuceMessageTimer {
  final NativeEngineBindings _bindings;
  bool _running = false;

  JuceMessageTimer(this._bindings);

  /// 定期的に JUCE のメッセージを処理するタイマーを開始
  void start() {
    if (_running) return;
    _running = true;
    _run();
  }

  void _run() async {
    while (_running) {
      final code = _bindings.dispatchNextJuceMessage();
      if (code != 0) {
        Logger.log("Error: failed to dispatchNextJUCEMessage. (code=$code)");
      }
      await Future<void>.delayed(const Duration(milliseconds: 16));
    }
  }

  void stop() {
    _running = false;
  }
}
