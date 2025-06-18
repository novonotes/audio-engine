import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_engine/src/engine_session.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/initialize_engine_request.dart';
import 'package:audio_engine/src/logger.dart';
import 'package:audio_engine/src/out_process_engine/socket_connection_adapter.dart';
import 'package:nam/nam.dart';

/// エンジンのサブプロセスの起動と終了を担当するクラス
class EngineSubprocess {
  final String udsPath;
  final String executablePath;
  final int sessionId;

  int? get pid => _process?.pid;

  Process? _process;
  StreamSubscription<String>? _stdoutSub;
  StreamSubscription<String>? _stderrSub;

  EngineSubprocess({
    required this.udsPath,
    required this.executablePath,
    required this.sessionId,
  });

  Future<void> start() async {
    Logger.log("AudioEngineService executable: $executablePath");
    var process = await Process.start(executablePath, [
      "--unix-socket",
      udsPath,
      "--session-id",
      "$sessionId",
    ]);
    Logger.log("AudioEngineService process started.");

    _stdoutSub = process.stdout
        .transform(utf8.decoder)
        .listen((message) => Logger.log("[engine stdout] $message"));

    _stderrSub = process.stderr.transform(utf8.decoder).listen((message) {
      Logger.log("[engine stderr] $message");
    });

    _process = process;
  }

  Future<void> shutdown() async {
    if (_process == null) return;

    final process = _process!;

    final killed = process.kill();
    if (!killed) {
      throw Exception("The signal could not be sent to the subprocess.");
    }

    final exitCode = await process.exitCode;
    if (!Platform.isWindows && exitCode != 0 && exitCode != -15) {
      throw Exception(
        "The engine subprocess has terminated with nonzero exit code: $exitCode",
      );
    }
    Logger.log(
      "The engine subprocess has terminated with exit code: $exitCode",
    );

    await _stdoutSub?.cancel();
    await _stderrSub?.cancel();
    _process = null;
  }
}

/// このパッケージによって生成・管理されるエンジンのプロセスとのセッション
class SubprocessEngineSession implements OutProcessEngineSession {
  int? get pid => _subprocess?.pid;
  EngineSubprocess? _subprocess;
  SocketConnectionAdapter? _connection;
  final NamSessionManager _sessionManager;
  int? _sessionId;
  final String udsPath;
  final String executablePath;

  @override
  String get sessionId {
    final s = _sessionId;
    if (s == null) {
      throw Exception("Session is not started yet.");
    }
    return s.toString();
  }

  SubprocessEngineSession(
    this._sessionManager, {
    required this.udsPath,
    required this.executablePath,
  });

  @override
  Future<void> startSession() async {
    _sessionId = _sessionManager.newSession();
    _subprocess = EngineSubprocess(
      udsPath: udsPath,
      executablePath: executablePath,
      sessionId: _sessionId!,
    );
    await _subprocess!.start();
  }

  final _connectionCompleter = Completer<void>();
  Future<void> waitForConnection() => _connectionCompleter.future;

  Future<void> onConnected(NamSocketConnection connection) async {
    final adapter = SocketConnectionAdapter(connection);
    _connection = adapter;
    _descriptor = await initializeEngineRequest(adapter);
    _connectionCompleter.complete();
  }

  bool alreadyStopped = false;

  @override
  Future<void> endSession() async {
    if (alreadyStopped) return;
    alreadyStopped = true;

    await _connection?.close();
    await _subprocess?.shutdown();
    if (_sessionId != null) {
      _sessionManager.onDisconnected(_sessionId!);
      _sessionId = null;
    }
  }

  NativeEngineRuntimeMetadata? _descriptor;

  @override
  NativeEngineRuntimeMetadata get nativeEngine {
    final d = _descriptor;
    if (d == null) {
      throw Exception(
        "Engine is not started. Please start the engine first.",
      );
    }
    return d;
  }

  @override
  EngineMessageChannel get channel {
    final c = _connection;
    if (c == null) {
      throw Exception("Subprocess engine is not connected yet.");
    }
    return c;
  }
}
