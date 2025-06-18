import 'dart:async';
import 'dart:io';

import 'package:nam/src/connection.dart';

import 'logger.dart';
import 'session_manager.dart';

class NamSocketServer {
  final ServerSocket socket;
  final NamSessionManager _sessionManager;

  /// ハンドシェイク完了後に [NamSocketConnection] を流す
  final _connectionController = StreamController<NamSocketConnection>();

  Stream<NamSocketConnection> get connectionStream =>
      _connectionController.stream;

  StreamSubscription<Socket>? _sub;

  NamSocketServer(
    this.socket, {
    NamSessionManager? sessionManager,
  }) : _sessionManager = sessionManager ?? NamSessionManager() {
    _sub = socket.listen(_handleConnection);
    Logger.log(
      "Listening host: ${socket.address.address}, port: ${socket.port}",
    );
  }

  Future<void> _handleConnection(Socket clientSocket) async {
    Logger.log('Connection from'
        ' ${clientSocket.remoteAddress.address}:${clientSocket.remotePort}.');
    final connection = NamSocketConnection(clientSocket, _sessionManager);

    // ハンドシェイク完了を待つ
    await connection.waitForHandshake();
    _connectionController.add(connection);
  }

  Future<void> shutdown() async {
    await _sub?.cancel();
    await _connectionController.close();
  }
}
