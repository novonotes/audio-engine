import 'dart:async';
import 'package:audio_engine/src/engine_session.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/initialize_engine_request.dart';
import 'package:audio_engine/src/out_process_engine/socket_connection_adapter.dart';
import 'package:nam/nam.dart';

/// 外部プロセスにより管理されており、このライブラリで寿命管理できないエンジンとのセッション。
/// 例: 他社製DAWアプリケーション内で動作するプラグインインスタンス。
class UnmanagedEngineSession implements OutProcessEngineSession {
  SocketConnectionAdapter? _connection;

  @override
  EngineMessageChannel get channel {
    final c = _connection;
    if (c == null) {
      throw Exception("Engine not connected yet");
    }
    return c;
  }

  @override
  String get sessionId {
    final c = _connection;
    if (c == null) {
      throw Exception("Engine not connected yet");
    }
    return c.sessionId.toString();
  }

  UnmanagedEngineSession();

  Future<void> onConnected(NamSocketConnection connection) async {
    _connection = SocketConnectionAdapter(connection);
    _descriptor = await initializeEngineRequest(_connection!);
  }

  @override
  Future<void> startSession() async {
    // Do nothing.
  }

  @override
  Future<void> endSession() async {
    await _connection?.close();
  }

  NativeEngineRuntimeMetadata? _descriptor;

  @override
  NativeEngineRuntimeMetadata get nativeEngine {
    final d = _descriptor;
    if (d == null) {
      throw Exception(
        "Client is not connected yet. Wait for the connection using the `ready` field.",
      );
    }
    return d;
  }
}
