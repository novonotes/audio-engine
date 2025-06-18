import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'logger.dart';

import 'message.dart';
import 'package:uds_win/uds_win.dart' as uds_win;

class NamSocketClient {
  final Socket socket;
  int _sessionId;
  int get sessionId => _sessionId;

  final _messagesFromServerStreamController = StreamController<Message>();

  /// server からの message を受け取るための stream
  Stream<Message> get messagesFromServer =>
      _messagesFromServerStreamController.stream;

  final MessageBuilder _builder = MessageBuilder();

  final _handshakeCompleter = Completer<void>();

  /// handshake が完了して、メッセージ送信の準備ができるのを待つための future。
  Future<void> get ready => _handshakeCompleter.future;

  /// [sessionId] = 0 は新規セッションを意味する。
  /// ハンドシェイク時にサーバー側によって新しい session id が割り当てられる。
  static Future<NamSocketClient> connect(
    InternetAddress address,
    int port, {
    int sessionId = 0,
  }) async {
    final sock = await uds_win.Socket.connect(address, port);
    return NamSocketClient._(sock, sessionId);
  }

  StreamSubscription<Uint8List>? _sub;

  NamSocketClient._(this.socket, this._sessionId) {
    // listen for responses from the server
    _sub = socket.listen(
      // handle data from the server
      (data) {
        try {
          final messages = _builder.build(data);
          for (final message in messages) {
            if (message.bodyType == 0) {
              if (_handshakeCompleter.isCompleted) {
                Logger.log(
                  "Received handshake ACK message from server. "
                  "Ignored the message because handshake is already completed.",
                );
                return;
              }
              _handleHandshakeMessageAck(message);
              return;
            }
            if (message.sessionId != _sessionId) {
              throw Exception(
                "Received a message with invalid session id",
              );
            }
            _messagesFromServerStreamController.add(message);
          }
        } catch (e) {
          _messagesFromServerStreamController.addError(e);
        }
      },

      // handle server ending connection
      onDone: () {
        Logger.log('Connection closed. (sessionId=$_sessionId)');
        socket.close();
      },
    );

    /// Handshake の INIT メッセージの送信。
    socket.add(Message.from(
      sessionId: _sessionId,
      bodyType: 0,
      body: Uint8List(0),
      context: Uint8List(0),
    ).buffer);
    Logger.log("Sent handshake message INIT to server.");
  }

  void _handleHandshakeMessageAck(final Message message) {
    if (message.bodyType != 0) {
      throw Exception("Handshake failed: invalid body type from server.");
    }
    _sessionId = message.sessionId;
    Logger.log("sessionId: ${message.sessionId}");

    // Server に RDY の送信
    socket.add(Message.from(
      sessionId: 0,
      bodyType: 0,
      body: Uint8List(0),
      context: Uint8List(0),
    ).buffer);
    Logger.log("Sent handshake message RDY to server.");
    _handshakeCompleter.complete();
  }

  /// server に message を送る
  void sendMessage(
    final int bodyType,
    final Uint8List body,
    final Uint8List context,
  ) {
    if (bodyType == 0) {
      Logger.log(
        "Warning: Sending message with body type 0. "
        "But 0 is reserved for handshake.",
      );
    }
    socket.add(Message.from(
      sessionId: _sessionId,
      bodyType: bodyType,
      body: body,
      context: context,
    ).buffer);
  }

  Future<void> close() async {
    await _sub?.cancel();
    await socket.close();
  }
}
