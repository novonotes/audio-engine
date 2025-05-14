import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_engine/src/engine_session.dart';
import 'package:audio_engine/src/in_process_engine/in_process_engine_session.dart';
import 'package:audio_engine/src/out_process_engine/unmanaged_engine_session.dart';
import 'package:audio_engine/src/logger.dart';
import 'package:audio_engine/src/out_process_engine/subprocess_engine_session.dart';
import 'package:collection/collection.dart';
import 'package:nam/nam.dart' as nam;
import 'package:nam/fs.dart' as fs;
import 'package:path/path.dart';

class EngineSessionManager {
  /// Keys are engine session IDs;
  final Map<String, EngineSessionPrivateInterface> _sessions = {};

  /// サブプロセスは起動したが、まだ接続が確立していないインスタンスを一時的に保持するための Map。
  final Map<String, SubprocessEngineSession> _tmpSessions = {};
  final _sessionManager = nam.NamSessionManager();

  final _addedStreamController = StreamController<EngineSession>.broadcast();
  final _removedStreamController = StreamController<String>.broadcast();
  Stream<EngineSession> get sessionAddedStream => _addedStreamController.stream;

  /// 削除された EngineSession の sessionID を Stream で取得する。
  Stream<String> get sessionRemovedStream => _removedStreamController.stream;

  nam.NamSocketServer? _socketServer;

  EngineSessionManager();

  /// In-process Audio Engine を起動する。
  ///
  /// [libraryPath] が null の場合、すでに library は link 済みのものとして、シンボルの look up を行う。
  ///
  /// すでに稼働中のエンジンが存在する場合は、Audio Engine を再起動する。
  /// 再起動の場合は、libraryPath の引数は無視され、初回呼び出し時のものが使用される。
  Future<EngineSession> startInProcessAudioEngine(
    String? libraryPath,
  ) async {
    // _inProcessEngineManager がまだ存在しない場合のみ初期化する
    if (libraryPath != null) {
      final exists = await File(libraryPath).exists();
      if (!exists) {
        throw Exception("Library file does not exist: $libraryPath");
      }
    }
    final EngineSessionPrivateInterface engine =
        InProcessEngineSession(libraryPath, _sessionManager);

    await engine.startSession();

    _addSession(engine);
    return engine;
  }

  // OutProcessEngine を受け入れるための、UDS サーバーを起動する。
  Future<void> startAcceptingOutProcessEngineUds(String socketFilePath) async {
    final path = absolute(normalize(socketFilePath));

    // バイト数の制限を検証
    {
      List<int> encoded = utf8.encode(path);
      if (encoded.length > 103) {
        throw SocketException(
          "The address exceeds the maximum allowed length of 103 bytes. Please provide a shorter path.",
          address: InternetAddress(
            path,
            type: InternetAddressType.unix,
          ),
        );
      }
    }

    // File が存在していたら例外投げる
    if (fs.existsSync(path)) {
      throw Exception(
        "A file already exists at the specified path: $socketFilePath",
      );
    }

    // 親 Directory が存在することを保証
    await File(path).parent.create(recursive: true);

    // UDS の場合、多分 port ナンバーは使われない
    const port = 0;

    final host = InternetAddress(
      path,
      type: InternetAddressType.unix,
    );
    await startAcceptingOutProcessEngine(host, port);
  }

  // OutProcessEngine を受け入れるための、ソケットサーバーを起動する。
  //
  // launchOutProcessAudioEngine を呼び出す前に最低一度呼び出す必要がある。
  // 複数回呼び出してた場合、2度目以降は何もせず処理を返す。
  Future<void> startAcceptingOutProcessEngine(
      InternetAddress host, int port) async {
    if (_socketServer != null) {
      return;
    }
    final socket = await nam.ServerSocket.bind(host, port);
    _socketServer = nam.NamSocketServer(
      socket,
      sessionManager: _sessionManager,
    );
    _socketServer!.connectionStream.listen((connection) async {
      try {
        await _handleSocketConnection(connection);
      } catch (e, s) {
        Logger.log(
            "A new audio engine client connected, but failed to initialize. (detail=$e)");
        Logger.log(s);
        _addedStreamController.addError(e);
      }
    });
    Logger.log("Audio engine socket server is listening on $host:$port");
  }

  Future<void> _handleSocketConnection(
    nam.NamSocketConnection connection,
  ) async {
    Logger.log(
      "New client connected. (sessionId=${connection.sessionId}, address=${connection.socket.remoteAddress})",
    );
    final SubprocessEngineSession? engineToBind = _tmpSessions.values
        .whereType<SubprocessEngineSession>()
        .firstWhereOrNull((engine) {
      return engine.sessionId == connection.sessionId.toString();
    });
    // 紐づける先の SubprocessEngine が見つからなかった場合は、
    // ExternalEngine のインスタンスを作成して追加。
    if (engineToBind == null) {
      final engine = UnmanagedEngineSession();
      await engine.onConnected(connection);
      _addSession(engine);
      connection.state.listen((newState) {
        if (newState == nam.ConnectionState.disconnected) {
          endSession(engine.sessionId);
        }
      });
      return;
    }

    // 紐づける先の SubprocessEngine が見つかった場合は、
    // その SubprocesEngine の onConnected を呼び出し。
    await engineToBind.onConnected(connection);
    connection.state.listen((newState) {
      if (newState == nam.ConnectionState.disconnected) {
        endSession(engineToBind.sessionId);
      }
    });
  }

  /// Subprocess Audio Engine を起動する。
  ///
  /// すでにプロセスが存在する場合は、プロセスを再起動する。
  Future<EngineSession> startSubprocessAudioEngine(
    String executablePath,
  ) async {
    final server = _socketServer;
    if (server == null) {
      throw Exception("Call startAcceptiongOutProcessEngine first.");
    }
    final udsPath = server.socket.address.host;
    final session = SubprocessEngineSession(
      _sessionManager,
      udsPath: udsPath,
      executablePath: executablePath,
    );

    try {
      await session.startSession();
      _tmpSessions[session.sessionId] = session;
      await session.waitForConnection();
    } finally {
      _tmpSessions.remove(session.sessionId);
    }

    _addSession(session);
    return session;
  }

  /// 現在セッションが維持されている [EngineSession] のリストを返す。
  List<EngineSession> listAllEngines() {
    return _sessions.values.toList();
  }

  Future<void> endSession(String sessionId) async {
    try {
      final found = _sessions[sessionId];
      if (found == null) {
        Logger.log("Failed to end session. Session not found: $sessionId");
        return;
      }
      await found.endSession();
    } finally {
      _sessions.remove(sessionId);
      _removedStreamController.add(sessionId);
      Logger.log("Engine removed: $sessionId");
    }
  }

  void _addSession(EngineSessionPrivateInterface engine) {
    _sessions[engine.sessionId] = engine;
    _addedStreamController.add(engine);
    Logger.log(
      "Engine added: (type=${engine.runtimeType}, id=${engine.sessionId}, descriptor=${engine.nativeEngine})",
    );
  }

  bool _alreadyDisposed = false;

  /// EngineControllerManager の Object を破棄する
  Future<void> dispose() async {
    if (_alreadyDisposed == true) {
      return;
    } else {
      _alreadyDisposed = true;
    }

    Logger.log("disposing EngineControllerManager");

    // 全てのセッションを終了。
    await Future.wait(
      _sessions.values.map((session) => session.endSession()),
    );

    // uds file の破棄
    {
      final address = _socketServer?.socket.address;
      if (address != null && address.type == InternetAddressType.unix) {
        final path = address.address;
        if (fs.existsSync(path)) {
          fs.deleteSync(path);
        }
      }
    }

    Logger.log("EngineControllerManager has been disposed successfully");
  }
}
