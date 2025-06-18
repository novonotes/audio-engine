import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:nam/src/logger.dart';
import 'package:nam/src/message.dart';
import 'package:nam/src/session_manager.dart';

/// 接続状態を表す enum
enum ConnectionState {
  connected, // 接続中
  disconnected, // 切断済み
}

enum _HandshakeState {
  waitingForInitMessage,
  waitingForRdyMessage,
  completed,
}

/// Client との接続を表す。サーバーから Client にメッセージを送ることが可能。
class NamSocketConnection {
  final Socket socket;
  SessionId? _sessionId;
  SessionId get sessionId {
    final s = _sessionId;
    if (s == null) {
      throw Exception(
        "Session id is not assigned. Handshake is not completed.",
      );
    }
    return s;
  }

  final MessageBuilder _builder = MessageBuilder();
  final NamSessionManager _sessionManager;

  _HandshakeState _handshakeState = _HandshakeState.waitingForInitMessage;
  final _handshakeCompleter = Completer<void>();

  // Handshake 以外のメッセージを流す。
  final _messageStreamController = StreamController<Message>();

  Stream<Message> get messagesFromClient => _messageStreamController.stream;

  // Handshake を含む Client からの全てのメッセージの Stream。
  Stream<Message> get _receivedMessageStream => socket.expand(_builder.build);

  final _connectionStateController = StreamController<ConnectionState>();

  /// 接続状態のストリーム
  Stream<ConnectionState> get state => _connectionStateController.stream;

  NamSocketConnection(this.socket, this._sessionManager) {
    // 初期状態を接続中に設定
    _connectionStateController.add(ConnectionState.connected);

    // 受信ストリーム購読開始
    _receivedMessageStream.listen(
      (message) {
        if (message.bodyType == 0) {
          // ハンドシェイクメッセージ処理
          _handleHandshakeMessage(message);
        } else {
          // 通常メッセージ処理
          _handleNonHandshakeMessage(message);
        }
      },
      onDone: () async {
        close();
      },
      onError: (error) async {
        Logger.log('Socket error: $error');
        close();
      },
    );
  }

  Future<void> waitForHandshake() => _handshakeCompleter.future;

  void sendMessage(BodyType bodyType, Uint8List body, Uint8List context) {
    if (bodyType == 0) {
      Logger.log(
        "Warning: Sending message with body type 0. "
        "But 0 is reserved for handshake.",
      );
    }
    Logger.log(
      "Nam message sending. { sessionId: $_sessionId, bodyType: $bodyType }",
    );
    socket.add(Message.from(
      sessionId: sessionId,
      bodyType: bodyType,
      body: body,
      context: context,
    ).buffer);
  }

  Future<void> close() async {
    await socket.close();
    _sessionManager.onDisconnected(sessionId);
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.disconnected);
      await _connectionStateController.close();
    }
    await _messageStreamController.close();
    Logger.log('Connection closed. (sessionId=$_sessionId)');
  }

  void _handleHandshakeMessage(Message message) {
    try {
      switch (_handshakeState) {
        case _HandshakeState.waitingForInitMessage:
          _handleHandshakeMessageInit(message);
          break;
        case _HandshakeState.waitingForRdyMessage:
          _handleHandshakeMessageRdy(message);
          break;
        case _HandshakeState.completed:
          // すでにハンドシェイク完了なら無視
          break;
      }
    } catch (e) {
      final convertedException = _convertHandshakeException(e);
      Logger.log(convertedException);
      _messageStreamController.addError(convertedException);
    }
  }

  void _handleHandshakeMessageInit(Message message) {
    Logger.log(
      "Received handshake message INIT from client. (sessionId=${message.sessionId})",
    );
    if (message.version != 0) {
      throw Exception(
        "Socket client is using unsupported protocol version.",
      );
    }

    _handshakeState = _HandshakeState.waitingForRdyMessage;

    final sessionExists = _sessionManager.sessionExists(message.sessionId);
    if (sessionExists) {
      _sessionId = message.sessionId;
      _sessionManager.onReconnected(message.sessionId);
    } else {
      _sessionId = _sessionManager.newSession();
    }

    // Client に ACK 送信。
    final s = _sessionId!;
    socket.add(
      Message.from(
        sessionId: s,
        bodyType: 0,
        body: Uint8List(0),
        context: Uint8List(0),
      ).buffer,
    );
    Logger.log("Sent handshake message ACK to client. (sessionId=$s)");
  }

  void _handleHandshakeMessageRdy(Message message) {
    Logger.log("Received handshake message RDY from client.");
    if (message.bodyType != 0) {
      throw Exception("Invalid body type in RDY from client.");
    }
    _handshakeState = _HandshakeState.completed;
    _handshakeCompleter.complete();
    Logger.log("Handshake succeeded.");
  }

  void _handleNonHandshakeMessage(Message message) {
    Logger.log(
      "Nam message received. { sessionId: $_sessionId, bodyType: ${message.bodyType} }",
    );
    if (message.sessionId != _sessionId) {
      _messageStreamController.addError(Exception(
        "Received a message with an unexpected sessionId. Expected: $_sessionId, Received: ${message.sessionId}",
      ));
      return;
    }
    _messageStreamController.add(message);
  }

  Exception _convertHandshakeException(Object e) {
    if (e is StateError && e.message.contains("No element")) {
      return Exception(
        "Handshake failed: $e "
        "(Connection may be closed by the client before the handshake completes.)",
      );
    }
    return Exception("Handshake failed: $e");
  }
}
