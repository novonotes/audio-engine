import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:audio_engine/src/in_process_engine/constants/status_code.dart';
import 'package:audio_engine/src/logger.dart';
import 'package:ffi/ffi.dart';

class NativeEngineBindingsException implements Exception {
  final int statusCode;
  final String methodName;

  NativeEngineBindingsException({
    required this.statusCode,
    required this.methodName,
  });

  @override
  String toString() {
    return "Failed to execute engine method. (method=$methodName, code=$statusCode, message=${getErrorMessage(statusCode)})";
  }
}

/// 非同期処理の結果を受け取るコールバック
typedef StatusCodeCallback = Void Function(IntPtr);

typedef FInitDartApiNative = Void Function(
  Pointer<Void>,
  Int32,
  Pointer<NativeFunction<StatusCodeCallback>>,
);
typedef FInitDartApi = void Function(
  Pointer<Void>,
  int,
  Pointer<NativeFunction<StatusCodeCallback>>,
);

typedef FInitMessageManagerNative = Void Function(
    IntPtr, Pointer<NativeFunction<StatusCodeCallback>>);
typedef FInitMessageManager = void Function(
    int, Pointer<NativeFunction<StatusCodeCallback>>);

typedef FInitEngineNative = Void Function(
    Int64, Pointer<NativeFunction<StatusCodeCallback>>);
typedef FInitEngine = void Function(
    int, Pointer<NativeFunction<StatusCodeCallback>>);

typedef FShutdownEngineNative = Void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);
typedef FShutdownEngine = void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);
typedef FShutdownMessageManagerNative = Void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);
typedef FShutdownMessageManager = void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);

typedef FShutdownDartApiNative = Void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);
typedef FShutdownDartApi = void Function(
    Pointer<NativeFunction<StatusCodeCallback>>);

typedef FSendMessageToEngineNative = Void Function(
  Pointer<Void> msg,
  Int32 len,
  Pointer<NativeFunction<StatusCodeCallback>>,
);
typedef FSendMessageToEngine = void Function(
  Pointer<Void> msg,
  int len,
  Pointer<NativeFunction<StatusCodeCallback>>,
);

typedef FDispatchNextJuceMessageNative = IntPtr Function();
typedef FDispatchNextJuceMessage = int Function();

typedef FGetStateNative = IntPtr Function();
typedef FGetState = int Function();

class NativeEngineBindings {
  late FInitDartApi _initDartApi;
  late FInitMessageManager _initMessageManager;
  late FInitEngine _initEngine;
  late FShutdownEngine _shutdownEngine;
  late FShutdownMessageManager _shutdownMessageManager;
  late FShutdownDartApi _shutdownDartApi;

  late FSendMessageToEngine _sendMessageToEngine;
  late FDispatchNextJuceMessage _dispatchNextJuceMessage;
  late FGetState _getState;

  final DynamicLibrary _dylib;
  final bool _skipClosingLibrary;

  factory NativeEngineBindings.process() {
    Logger.log("opening audio engine dll.");
    final dylib = DynamicLibrary.process();
    Logger.log("opened audio engine dll: ${dylib.handle.address}");
    final bindings = NativeEngineBindings._(dylib, true);
    return bindings;
  }

  factory NativeEngineBindings.open(String libraryPath) {
    Logger.log("opening audio engine dll.");
    final dylib = DynamicLibrary.open(libraryPath);
    Logger.log("opened audio engine dll: ${dylib.handle.address}");
    final bindings = NativeEngineBindings._(dylib, false);
    return bindings;
  }

  NativeEngineBindings._(this._dylib, this._skipClosingLibrary) {
    _initDartApi = _dylib
        .lookup<NativeFunction<FInitDartApiNative>>('initDartApi')
        .asFunction();

    _initEngine = _dylib
        .lookup<NativeFunction<FInitEngineNative>>('initEngine')
        .asFunction();

    _initMessageManager = _dylib
        .lookup<NativeFunction<FInitMessageManagerNative>>(
          'initMessageManager',
        )
        .asFunction();

    _shutdownEngine = _dylib
        .lookup<NativeFunction<FShutdownEngineNative>>('shutdownEngine')
        .asFunction();

    _shutdownMessageManager = _dylib
        .lookup<NativeFunction<FShutdownMessageManagerNative>>(
          'shutdownMessageManager',
        )
        .asFunction();

    _shutdownDartApi = _dylib
        .lookup<NativeFunction<FShutdownDartApiNative>>('shutdownDartApi')
        .asFunction();

    _sendMessageToEngine = _dylib
        .lookup<NativeFunction<FSendMessageToEngineNative>>(
          'sendMessageToEngine',
        )
        .asFunction();

    _dispatchNextJuceMessage = _dylib
        .lookup<NativeFunction<FDispatchNextJuceMessageNative>>(
          'dispatchNextJuceMessage',
        )
        .asFunction();
    _getState =
        _dylib.lookup<NativeFunction<FGetStateNative>>('getState').asFunction();
  }

  void dispose() {
    if (!_skipClosingLibrary) {
      _dylib.close();
    }
  }

  Future<void> initDartApi() async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("init dart api >>>");
    _initDartApi(NativeApi.initializeApiDLData, 0, callback.nativeFunction);
    final result = await completer.future;
    Logger.log("init dart api <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "initDartAPI",
        statusCode: result,
      );
    }
  }

  /// [topLevelWindowHandle] は Top level window のハンドルのアドレス。
  /// 利用できない場合は、0 を指定することができる。この場合 Top level window に依存しない形で Message Manager 初期化を試みる。
  Future<void> initMessageManager(int topLevelWindowHandle) async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("init message manager >>>");
    _initMessageManager(topLevelWindowHandle, callback.nativeFunction);
    final result = await completer.future;
    Logger.log("init message manager <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "initMessageManager",
        statusCode: result,
      );
    }
  }

  Future<void> initEngine(int dartPortId) async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("init engine >>>");
    _initEngine(dartPortId, callback.nativeFunction);
    final result = await completer.future;
    Logger.log("init engine <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "initEngine",
        statusCode: result,
      );
    }
  }

  Future<void> shutdownEngine() async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("shutdown engine >>>");
    _shutdownEngine(callback.nativeFunction);
    final result = await completer.future;
    Logger.log("shutdown engine <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "shutdownEngine",
        statusCode: result,
      );
    }
  }

  Future<void> shutdownMessageManager() async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("shutdown message manager >>>");
    _shutdownMessageManager(callback.nativeFunction);
    final result = await completer.future;
    Logger.log("shutdown message manager <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "shutdownMessageManager",
        statusCode: result,
      );
    }
  }

  Future<void> shutdownDartApi() async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    Logger.log("shutdown dart api >>>");
    _shutdownDartApi(callback.nativeFunction);
    final result = await completer.future;
    Logger.log("shutdown dart api <<<");

    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "shutdownDartAPI",
        statusCode: result,
      );
    }
  }

  Future<void> sendMessageToEngine(Uint8List data) async {
    final completer = Completer<int>();
    void onStatusCode(int code) {
      if (!completer.isCompleted) {
        completer.complete(code);
      }
    }

    final callback = NativeCallable<StatusCodeCallback>.listener(onStatusCode);

    final pointer = data.allocateAndCopyToPointer();

    Logger.log("send message to engine >>>");
    _sendMessageToEngine(pointer, data.length, callback.nativeFunction);
    final result = await completer.future;
    Logger.log("send message to engine <<<");

    malloc.free(pointer);
    callback.close();

    if (result != 0) {
      throw NativeEngineBindingsException(
        methodName: "sendMessageToEngine",
        statusCode: result,
      );
    }
  }

  int dispatchNextJuceMessage() {
    return _dispatchNextJuceMessage();
  }

  int getState() {
    return _getState();
  }
}

extension _ToPointerExtension on Uint8List {
  /// このメソッドで作成したポインタはかならず malloc.free を用いて解放すること
  Pointer<Void> allocateAndCopyToPointer() {
    final pointer = malloc.allocate<Uint8>(length);
    // データを native heap にコピーする
    pointer.asTypedList(length).setAll(0, this);
    final voidPointer = pointer.cast<Void>();
    return voidPointer;
  }
}
