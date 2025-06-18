import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:audio_engine/src/in_process_engine/juce_message_timer.dart';
import 'package:audio_engine/src/platform/audio_engine_platform_interface.dart';
import 'package:audio_engine/src/in_process_engine/constants/api_state.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/logger.dart';
import 'package:nam/nam.dart';

import 'native_engine_bindings.dart';

/// In-process で動作するオーディオエンジン。
/// [EngineMessageChannel] のインターフェースを実装しており、メッセージ送受信が可能。
///
/// 機能:
/// - エンジン初期化
/// - エンジン終了処理
/// - エンジンとのメッセージ送受信
class InProcessEngine implements EngineMessageChannel {
  final NativeEngineBindings _bindings;
  final NamSessionManager _sessionManager;
  final List<Future<void>> _pendingMessages = [];
  JuceMessageTimer? _juceMessageTimer;

  SessionId? _sessionId;
  SessionId get sessionId {
    final s = _sessionId;
    if (s == null) {
      throw Exception(
        "Engine is not initialized. Please initialize the engine first.",
      );
    }
    return s;
  }

  Stream<Message>? _receivedMessages;

  final _handshakeCompleter = Completer<void>();

  InProcessEngine(String? libraryPath, this._sessionManager)
      : _bindings = libraryPath == null
            ? NativeEngineBindings.process()
            : NativeEngineBindings.open(libraryPath);

  static bool _engineInitializedDart = false;

  Future<void> initialize() async {
    final currentCppState = _bindings.getState();

    // 起動中のエンジンがある場合は再起動。
    // hotreload などで Dart 側の static 変数だけ初期化され、
    // C++ 側の static 変数が初期化されないケースがある。
    if (_engineInitializedDart == false &&
        currentCppState == ApiState.ENGINE_INITIALIZED) {
      await _shutdown();
    }

    _sessionId = _sessionManager.newSession();

    await _bindings.initDartApi();
    int? topLevelWindowHandle =
        await AudioEnginePlatform.instance.getTopLevelWindowHandle();
    await _bindings.initMessageManager(topLevelWindowHandle ?? 0);

    // Flutter アプリではメインスレッドにすでに存在するイベントループを使って
    // JUCE の MessageManager を初期化するので、
    // Dart 側で Timer を用意する必要はない。
    // ただしユニットテストなどでは、必要になることがある。
    bool isValidHandle =
        topLevelWindowHandle != null && topLevelWindowHandle != 0;
    if (Platform.isWindows && !isValidHandle) {
      _juceMessageTimer = JuceMessageTimer(_bindings)..start();
    }

    final receivePort = ReceivePort();
    _receivedMessages = receivePort.asBroadcastStream().map(
          (event) => Message(event as Uint8List),
        );

    unawaited(
      _handshake().catchError((Object e) {
        Logger.log("Handshake failed.");
        Logger.log(e);
        _handshakeCompleter.completeError(e);
      }).then((_) {
        _handshakeCompleter.complete();
      }),
    );

    final dartPortId = receivePort.sendPort.nativePort;
    await _bindings.initEngine(dartPortId);
    _engineInitializedDart = true;

    await _handshakeCompleter.future;
  }

  Future<void> _handshake() async {
    Logger.log("Handshake...");

    // INIT メッセージを待つ。
    Message mes = await receivedMessages.first.timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        throw TimeoutException(
          "Failed to receive Handshake INIT message from in-process engine.",
        );
      },
    );

    // INIT メッセージの Validation
    {
      // handshake に用いる bodyType は 0 とプロトコルで定義されている。
      if (mes.bodyType != 0) {
        throw Exception("Handshake failed. Invalid body type: ${mes.bodyType}");
      }
      if (mes.version != 0) {
        throw Exception(
          "In-process Audio Engine is using unsupported protocol version.",
        );
      }
    }

    // ACK メッセージを送信。
    unawaited(
      _sendMessage(
        Message.from(
          body: Uint8List(0),
          bodyType: 0,
          context: Uint8List(0),
          sessionId: sessionId,
        ),
      ),
    );

    // RDY メッセージを待つ。
    mes = await receivedMessages.first.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException(
          "Failed to receive Handshake RDY message from in-process engine.",
        );
      },
    );

    // RDY メッセージの Validation
    {
      // Handshake に用いる bodyType は 0 と NAM プロトコルで定義されている。
      if (mes.bodyType != 0) {
        throw Exception("Handshake failed. Invalid body type: ${mes.bodyType}");
      }
      if (mes.sessionId != sessionId) {
        throw Exception(
          "Handshake failed: invalid session id from in-process engine.",
        );
      }
    }

    Logger.log("Handshake succeeded");
  }

  Future<void> _sendMessage(Message msg) async {
    await _bindings.sendMessageToEngine(msg.buffer);
  }

  @override
  void sendMessage(
    BodyType bodyType,
    Uint8List messageContent,
    Uint8List context,
  ) {
    if (_disposed) {
      Logger.log(
          "Ignores a message (bodyType=$bodyType, reason='In-process engine is already disposed.')");
      return;
    }
    // メッセージ送信を Future で追跡
    // ignore: discarded_futures
    final messageFuture = _sendMessage(
      Message.from(
        sessionId: sessionId,
        bodyType: bodyType,
        body: messageContent,
        context: context,
      ),
    );
    _pendingMessages.add(messageFuture);

    // エラーハンドリング
    unawaited(
      messageFuture.catchError((Object e, StackTrace s) {
        Logger.log("Error: sendMessage failed.");
        Logger.log(e);
        Logger.log(s);
      }).whenComplete(() {
        _pendingMessages.remove(messageFuture);
      }),
    );
  }

  @override
  Stream<Message> get receivedMessages {
    final messages = _receivedMessages;
    if (messages == null) {
      throw Exception(
        "Engine is not initialized. Please initialize the engine first.",
      );
    }
    return messages.map((msg) {
      // 現在複数のエンジンインスタンスはサポートしていないので、自身と同じ sessionId のメッセージしか来ないはず
      if (_handshakeCompleter.isCompleted && msg.sessionId != _sessionId) {
        throw Exception("Unexpected Session ID");
      }
      return msg;
    });
  }

  @override
  TransportType get transportType => TransportType.ffi;
  bool _disposed = false;

  Future<void> _shutdown() async {
    // 全てのメッセージ送信が完了するのを待つ
    Logger.log("Waiting for message processing: ${_pendingMessages.length}");
    await Future.wait(_pendingMessages);
    Logger.log("Message processing completed.");
    _engineInitializedDart = false;

    await _bindings.shutdownEngine();
    await _bindings.shutdownMessageManager();
    await _bindings.shutdownDartApi();
    _juceMessageTimer?.stop();
    if (_sessionId != null) {
      _sessionManager.onDisconnected(_sessionId!);
      _sessionId = null;
    }
  }

  Future<void> dispose() async {
    _disposed = true;
    if (_bindings.getState() == ApiState.ENGINE_INITIALIZED) {
      await _shutdown();
    }
    _bindings.dispose();
  }
}
