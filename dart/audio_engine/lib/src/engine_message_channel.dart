import 'dart:typed_data';

import 'package:nam/nam.dart';

enum TransportType { ffi, socket }

/// Native Engine への Messsage の入出力。
///
/// 実装は UDS の Socket Server かもしれないし、FFI による言語間 Binding かもしれない。
abstract interface class EngineMessageChannel {
  void sendMessage(
    BodyType bodyType,
    Uint8List messageContent,
    Uint8List context,
  );

  /// AudioEngine から受けっとったメッセージのストリーム。
  /// 返り値は常に Broadcast Stream。
  Stream<Message> get receivedMessages;
  TransportType get transportType;
}
