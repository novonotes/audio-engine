import 'dart:async';
import 'dart:typed_data';

import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:nam/nam.dart';

/// [NamSocketConnection] を [EngineMessageChannel] として利用できるようにするアダプター
/// [NamSocketConnection] のオブジェクトを管理し、適切に close などの処理を実行する。
class SocketConnectionAdapter implements EngineMessageChannel {
  final NamSocketConnection _connection;

  int get sessionId => _connection.sessionId;

  SocketConnectionAdapter(this._connection) {
    receivedMessages = _connection.messagesFromClient.asBroadcastStream();
  }

  @override
  late final Stream<Message> receivedMessages;

  @override
  void sendMessage(BodyType bodyType, Uint8List body, Uint8List context) {
    _connection.sendMessage(bodyType, body, context);
  }

  @override
  TransportType get transportType => TransportType.socket;

  Future<void> close() async {
    await _connection.close();
  }
}
