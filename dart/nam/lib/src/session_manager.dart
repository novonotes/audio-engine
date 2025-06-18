import 'dart:async';
import 'dart:math';

import 'package:nam/src/logger.dart';

import 'constants.dart';
import 'message.dart';

class NamSessionManager {
  final Duration reconnectionTimeout;
  final Set<SessionId> _activeSessions = {};
  // セッションごとにタイマーを管理
  final Map<SessionId, Timer> _sessionTimers = {};

  /// [reconnectionTimeout] を超えて、接続がない場合にセッションを破棄する。
  NamSessionManager({this.reconnectionTimeout = const Duration(seconds: 60)});

  /// 新規セッション作成
  SessionId newSession() {
    final id = _generateRandomSessionId();
    final result = _activeSessions.add(id);
    if (result == false) {
      // id が重複してしまったためやり直し。
      return newSession();
    }
    return id;
  }

  /// セッションが存在するかどうか調べる。
  bool sessionExists(SessionId id) {
    return _activeSessions.contains(id);
  }

  void onReconnected(SessionId id) {
    if (!_activeSessions.contains(id)) {
      throw Exception("Session not found: $id");
    }
    _sessionTimers[id]?.cancel();
    _sessionTimers.remove(id);
  }

  void onDisconnected(SessionId id) {
    if (_sessionTimers[id] == null) {
      _sessionTimers[id] = Timer(reconnectionTimeout, () {
        _activeSessions.remove(id);
        _sessionTimers.remove(id);
        Logger.log("Session expired. (sessionId=$id)");
      });
    }
  }

  // ランダムな SessionId 生成
  SessionId _generateRandomSessionId() {
    final random = Random();
    // 1 から uint16Max までのランダムな数値。
    return random.nextInt(uint16Max) + 1;
  }
}
