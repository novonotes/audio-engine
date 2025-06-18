// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:uds_win/src/bindings.dart';
import 'package:uds_win/src/constants.dart';
import 'package:uds_win/src/structs.dart';
import 'package:win32/win32.dart';
import 'package:win32/winsock2.dart' as winsock2;

/// A cross-platform implementation of Socket that supports UNIX domain sockets (UDS).
///
/// - On Windows, this implementation provides a custom solution using Winsock2 for UDS.
/// - On non-Windows platforms, it delegates to the default Dart Socket.connect.
class Socket {
  /// Establishes a connection to the specified host and port.
  ///
  /// This method supports UNIX domain sockets on Windows by delegating to
  /// a custom SocketUdsWin implementation. On other platforms, it falls back
  /// to the default Dart implementation.
  static Future<io.Socket> connect(
    host,
    int port, {
    sourceAddress,
    int sourcePort = 0,
    Duration? timeout,
  }) async {
    if (io.Platform.isWindows &&
        host is io.InternetAddress &&
        host.type == io.InternetAddressType.unix) {
      return SocketUdsWin.createAndConnect(host.address);
    }
    return await io.Socket.connect(
      host,
      port,
      sourceAddress: sourceAddress,
      sourcePort: sourcePort,
      timeout: timeout,
    );
  }
}

/// Internal implementation of a UNIX domain socket client for Windows.
///
/// This class wraps Winsock2 APIs to provide support for UNIX domain sockets
/// on Windows. It integrates seamlessly into the cross-platform Socket abstraction.
class SocketUdsWin extends Stream<Uint8List> implements io.Socket {
  int _socket;
  final _controllerForReceivedMessageStream = StreamController<Uint8List>();
  Encoding _encoding = utf8;

  /// Creates a new SocketUdsWin instance and starts reading data.
  SocketUdsWin(this._socket) {
    _setNonBlocking();
    _startReading();
  }

  /// Creates a UNIX domain socket and connects to the specified path.
  static Future<SocketUdsWin> createAndConnect(String path) async {
    // Create a UNIX domain socket
    final socket = winsock2.socket(
        winsock2.AF_UNIX, winsock2.WINSOCK_SOCKET_TYPE.SOCK_STREAM, 0);
    if (socket == INVALID_SOCKET) {
      final errorCode = wsaGetLastError();
      throw WindowsException(HRESULT_FROM_WIN32(errorCode));
    }

    // Set up the address to connect to
    final sockaddrUn = calloc<SOCKADDR_UN>();
    sockaddrUn.ref.sun_family = winsock2.AF_UNIX;

    final pathBytes = path.codeUnits;
    if (pathBytes.length >= SOCKADDR_PATH_LENGTH - 1) {
      free(sockaddrUn);
      throw ArgumentError('Socket path is too long');
    }

    // Copy the UNIX path
    for (int i = 0; i < pathBytes.length; i++) {
      sockaddrUn.ref.sun_path[i] = pathBytes[i];
    }
    sockaddrUn.ref.sun_path[pathBytes.length] = 0;

    // Connect to the server
    final result =
        winsock2.connect(socket, sockaddrUn.cast(), sizeOf<SOCKADDR_UN>());
    if (result == SOCKET_ERROR) {
      free(sockaddrUn);
      final errorCode = wsaGetLastError();
      throw WindowsException(HRESULT_FROM_WIN32(errorCode));
    }

    free(sockaddrUn);

    // Return a wrapped socket
    return SocketUdsWin(socket);
  }

  /// Sets the socket to non-blocking mode.
  void _setNonBlocking() async {
    final mode = calloc<Uint32>();
    mode.value = 1; // 1 for non-blocking mode
    final ioctlResult = winsock2.ioctlsocket(_socket, FIONBIO, mode);
    free(mode);
    if (ioctlResult == SOCKET_ERROR) {
      final errorCode = wsaGetLastError();
      throw WindowsException(HRESULT_FROM_WIN32(errorCode));
    }
  }

  bool _isReading = false;

  /// Starts reading data periodically from the socket.
  void _startReading() async {
    _isReading = true;
    const interval = Duration(milliseconds: 16); // Adjust as needed
    while (_isReading) {
      _readSocket();
      await Future<void>.delayed(interval);
    }
  }

  void _stopReading() {
    _isReading = false;
  }

  /// Reads data from the socket in non-blocking mode.
  void _readSocket() {
    final bufferSize = 1024;
    final buffer = calloc<Uint8>(bufferSize);
    final bytesRead =
        winsock2.recv(_socket, buffer.cast<Utf8>(), bufferSize, 0);

    if (bytesRead > 0) {
      final data = buffer.asTypedList(bytesRead);
      _controllerForReceivedMessageStream.add(Uint8List.fromList(data));
    } else if (bytesRead == 0) {
      // Connection closed
      _controllerForReceivedMessageStream.close();
      _stopReading();
    } else {
      final errorCode = wsaGetLastError();
      if (errorCode == WSAEWOULDBLOCK) {
        // No data available, do nothing
      } else if (errorCode == WSAECONNRESET || errorCode == WSAENOTSOCK) {
        // Connection reset or socket closed
        _controllerForReceivedMessageStream.close();
        _stopReading();
      } else {
        // Other errors
        final exception = WindowsException(HRESULT_FROM_WIN32(errorCode));
        _controllerForReceivedMessageStream.addError(exception);
        _controllerForReceivedMessageStream.close();
        _stopReading();
      }
    }
    free(buffer);
  }

  // The remaining methods implement the io.Socket interface.
  @override
  Encoding get encoding => _encoding;

  @override
  set encoding(Encoding value) {
    _encoding = value;
  }

  @override
  void add(List<int> data) {
    write(data);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    throw UnimplementedError();
    // _controllerForReceivedMessageStream.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    return stream.listen((data) {
      write(data);
    }).asFuture();
  }

  @override
  io.InternetAddress get address =>
      io.InternetAddress("", type: io.InternetAddressType.unix);

  @override
  Future<void> close() async {
    if (_socket != INVALID_SOCKET) {
      winsock2.closesocket(_socket);
      _socket = INVALID_SOCKET;
    }
    _stopReading();
    if (_controllerForReceivedMessageStream.hasListener) {
      await _controllerForReceivedMessageStream.close().timeout(
        Duration(milliseconds: 300),
        onTimeout: () {
          print("Timeout: message stream failed to close.");
        },
      );
    }
  }

  @override
  void destroy() {
    close();
  }

  @override
  Future get done => _controllerForReceivedMessageStream.done;

  @override
  Future flush() async {
    // Write operations are immediate; nothing to flush
    return;
  }

  @override
  Uint8List getRawOption(io.RawSocketOption option) {
    throw UnimplementedError();
  }

  @override
  StreamSubscription<Uint8List> listen(void Function(Uint8List event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controllerForReceivedMessageStream.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  int get port => 0; // Port is not applicable for UNIX domain sockets

  @override
  io.InternetAddress get remoteAddress =>
      io.InternetAddress("", type: io.InternetAddressType.unix);

  @override
  int get remotePort => 0; // Port is not applicable for UNIX domain sockets

  @override
  bool setOption(io.SocketOption option, bool enabled) {
    throw UnimplementedError();
  }

  @override
  void setRawOption(io.RawSocketOption option) {
    throw UnimplementedError();
  }

  @override
  void write(Object? object) {
    List<int> data;
    if (object is String) {
      data = _encoding.encode(object);
    } else if (object is List<int>) {
      data = object;
    } else if (object is Uint8List) {
      data = object;
    } else {
      throw ArgumentError('Invalid data type for write');
    }

    int totalSent = 0;
    while (totalSent < data.length) {
      final toSend = data.length - totalSent;
      final buffer = calloc<Uint8>(toSend);
      final bufferList = buffer.asTypedList(toSend);
      bufferList.setAll(0, data.sublist(totalSent));

      final bytesSent = winsock2.send(_socket, buffer.cast<Utf8>(), toSend, 0);
      if (bytesSent == SOCKET_ERROR) {
        final errorCode = wsaGetLastError();
        free(buffer);
        if (errorCode == WSAECONNRESET) {
          return;
        }
        throw WindowsException(
          HRESULT_FROM_WIN32(errorCode),
          message: "Error on windsock2.send (address: ${address.address})",
        );
      }
      free(buffer);
      totalSent += bytesSent;
    }
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    bool first = true;
    for (var obj in objects) {
      if (!first) {
        write(separator);
      }
      write(obj);
      first = false;
    }
  }

  @override
  void writeCharCode(int charCode) {
    write(String.fromCharCode(charCode));
  }

  @override
  void writeln([Object? object = ""]) {
    write(object);
    write('\n');
  }
}
