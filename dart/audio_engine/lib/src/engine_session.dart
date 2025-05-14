import 'package:audio_engine/foundation.dart';

/// Native Engine 起動後に、そのインスタンスに問い合わせて取得した、そのインスタンス自身の Metadata 。
class NativeEngineRuntimeMetadata {
  final String engineTypeId;
  final String displayName;
  final String schemaVersion;
  final int pid;

  NativeEngineRuntimeMetadata({
    required this.engineTypeId,
    required this.displayName,
    required this.schemaVersion,
    required this.pid,
  });

  @override
  String toString() {
    return "{"
        "engineTypeId:'$engineTypeId',"
        "displayName:'$displayName',"
        "schemaVersion:'$schemaVersion',"
        "pid:'$pid',"
        "}";
  }
}

/// NativeEngine とのメッセージの一連のやり取り。
///
/// Public interface definition for [EngineSession]
abstract class EngineSession {
  String get sessionId;
  EngineMessageChannel get channel;
  NativeEngineRuntimeMetadata get nativeEngine;
}

/// パッケージ内部からのみアクセス可能なインターフェース定義
abstract class EngineSessionPrivateInterface implements EngineSession {
  Future<void> startSession();
  Future<void> endSession();
}

abstract class OutProcessEngineSession
    implements EngineSessionPrivateInterface {}
