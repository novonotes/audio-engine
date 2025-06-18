import 'dart:async';
import 'package:audio_engine/src/engine_session.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/in_process_engine/in_process_engine.dart';
import 'package:audio_engine/src/initialize_engine_request.dart';
import 'package:nam/nam.dart';

class InProcessEngineSession implements EngineSessionPrivateInterface {
  final InProcessEngine _engine;

  InProcessEngineSession(
    String? libraryPath,
    NamSessionManager sessionIdGenerator,
  ) : _engine = InProcessEngine(libraryPath, sessionIdGenerator);

  @override
  EngineMessageChannel get channel => _engine;

  @override
  Future<void> endSession() async {
    await _engine.dispose();
  }

  @override
  String get sessionId => _engine.sessionId.toString();

  @override
  Future<void> startSession() async {
    await _engine.initialize();
    _engineMetadata = await initializeEngineRequest(channel);
  }

  NativeEngineRuntimeMetadata? _engineMetadata;

  @override
  NativeEngineRuntimeMetadata get nativeEngine {
    final d = _engineMetadata;
    if (d == null) {
      throw Exception(
        "Engine is not initialized. Please start a session with the engine first.",
      );
    }
    return d;
  }
}
