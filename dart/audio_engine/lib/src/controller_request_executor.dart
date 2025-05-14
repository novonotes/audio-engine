import 'dart:async';

import 'package:audio_engine/src/constants.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/generated/google/protobuf/struct.pb.dart';
import 'package:audio_engine/src/logger.dart';
import 'package:audio_engine/src/native_engine_error.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:audio_engine/src/generated/novonotes/audio_engine/v1alpha1/type/body_type.type.dart'
    as v1alpha1;

typedef RequestId = int;

const defaultRequestTimeout = Duration(seconds: 5);

class ControllerRequestExecutor {
  final EngineMessageChannel channel;

  final Map<RequestId, Completer<dynamic>> _requestCompleters = {};
  final Map<RequestId, StackTrace> _stackTraces = {};
  static int _requestCount = 1;
  static RequestId _newRequestId() {
    if (_requestCount >= Int64.MAX_VALUE.toInt()) {
      _requestCount = 1;
    }
    return _requestCount++;
  }

  ControllerRequestExecutor(this.channel);

  void handleError(Object error, RequestId requestId) {
    final completer = _requestCompleters[requestId];
    if (completer == null) {
      // 他の Controller がハンドリングするはず。
      return;
    }
    // Timeout などのエラーですでに完了している可能性もある。
    // その場合は complete を呼ばずに return する。
    if (completer.isCompleted == false) {
      final stackTrace = _stackTraces[requestId];
      completer.completeError(NativeEngineError(error), stackTrace);

      _requestCompleters.remove(requestId);
      _stackTraces.remove(requestId);
    }
  }

  void handleResponse<Response extends GeneratedMessage>(
      Response res, RequestId requestId) {
    final completer = _requestCompleters[requestId];
    if (completer == null) {
      return;
    }
    if (completer is! Completer<Response>) {
      throw StateError(
        "Completer type mismatch. (requestId=$requestId, ResponseType=$Response)",
      );
    }
    // Timeout などのエラーですでに完了している可能性もある。
    // その場合は complete を呼ばずに return する。
    if (completer.isCompleted == false) {
      completer.complete(res);

      _requestCompleters.remove(requestId);
      _stackTraces.remove(requestId);
    }
    return;
  }

  /// リクエストの実行
  ///
  /// [timeout] でリクエストがタイムアウトする時間を指定できる。
  /// この時間を経過してもレスポンスが得られない場合、
  /// [TimeoutException] がスローされます。 null を設定すると、タイムアウトが無効になり、
  /// 無限にレスポンスを待機する。
  Future<Response> execute<Request extends GeneratedMessage,
      Response extends GeneratedMessage>(
    Request req,
    SchemaVersion schemaVersion, {
    required Duration timeout,
  }) async {
    Logger.log("Sending: $Request ${req.toProto3Json()}");
    final reqId = _newRequestId();
    final bodyType = switch (schemaVersion) {
      SchemaVersion.v1alpha1 => v1alpha1.getBodyType<Request>(),
    };
    final context = Struct()..mergeFromProto3Json({"request-id": reqId});
    channel.sendMessage(
      bodyType.value,
      req.writeToBuffer(),
      context.writeToBuffer(),
    );
    final completer = Completer<Response>();
    _requestCompleters[reqId] = completer;
    _stackTraces[reqId] = StackTrace.current;

    final res = await completer.future.timeout(timeout, onTimeout: () {
      throw TimeoutException(
        "The $Request has timed out: ${req.toProto3Json()}",
      );
    });
    Logger.log("Received: $Response ${res.toProto3Json()}");
    return res;
  }
}
