import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:uds_win/src/bindings.dart';
import 'package:uds_win/src/constants.dart';
import 'package:uds_win/src/socket.dart';
import 'package:uds_win/src/structs.dart';
import 'package:win32/win32.dart';
import 'package:win32/winsock2.dart' as winsock2;

/// A cross-platform implementation of `ServerSocket` that supports UNIX domain sockets (UDS).
///
/// - On Windows, this implementation provides a custom solution using Winsock2 to enable UDS functionality.
/// - On non-Windows platforms, it delegates to the default Dart `ServerSocket.bind` implementation.
///
/// Usage:
/// ```dart
/// final serverSocket = await ServerSocket.bind(
///   io.InternetAddress('/path/to/socket'),
///   0,
/// );
/// serverSocket.listen((socket) {
///   // Handle incoming socket connection.
/// });
/// ```
abstract class ServerSocket {
  /// Binds a `ServerSocket` to the given address and port.
  ///
  /// This method is cross-platform:
  /// - On Windows, it uses a custom `_ServerSocketUdsWin` implementation for UNIX domain sockets.
  /// - On other platforms, it falls back to the native Dart `ServerSocket.bind`.
  ///
  /// Parameters:
  /// - [address]: The address to bind to. For UNIX sockets, this should be an `InternetAddress` with type `InternetAddressType.unix`.
  /// - [port]: The port to bind to. For UNIX domain sockets, this is typically 0.
  /// - [backlog]: The maximum number of pending connections (default is 0).
  /// - [v6Only]: Restricts socket to IPv6-only traffic (default is `false`).
  /// - [shared]: Allows multiple processes to bind to the same address/port (default is `false`).
  static Future<io.ServerSocket> bind(
    address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) async {
    if (address is io.InternetAddress &&
        io.Platform.isWindows &&
        address.type == io.InternetAddressType.unix) {
      return _ServerSocketUdsWin(address, port);
    }
    return await io.ServerSocket.bind(
      address,
      port,
      backlog: backlog,
      v6Only: v6Only,
      shared: shared,
    );
  }
}

/// Internal implementation of a UNIX domain socket server for Windows.
///
/// This class is specifically designed for Windows and uses Winsock2 APIs to
/// provide support for UNIX domain sockets. It is seamlessly integrated into
/// the cross-platform `ServerSocket` abstraction, making it invisible to the user
/// whether this implementation or the native Dart implementation is used.
class _ServerSocketUdsWin extends Stream<io.Socket> implements io.ServerSocket {
  @override
  final io.InternetAddress address;

  @override
  final int port;

  final int _socket;
  final _controllerForNewConnections = StreamController<io.Socket>();
  bool _winsockInitialized = false;

  /// Creates a new instance of `_ServerSocketUdsWin` and initializes the Winsock2 socket.
  _ServerSocketUdsWin(this.address, this.port) : _socket = _createSocket() {
    _winsockInitialized = true;
    _bindAndListen();
  }

  /// Creates a Winsock2 socket for UNIX domain communication.
  static int _createSocket() {
    final socket = winsock2.socket(
        winsock2.AF_UNIX, winsock2.WINSOCK_SOCKET_TYPE.SOCK_STREAM, 0);
    if (socket == INVALID_SOCKET) {
      final errorCode = wsaGetLastError();
      throw WindowsException(HRESULT_FROM_WIN32(errorCode));
    }
    return socket;
  }

  /// Binds the socket to the specified UNIX path and starts listening for connections.
  void _bindAndListen() {
    // TODO: Move to bind closure
    final sockaddrUn = calloc<SOCKADDR_UN>();
    // bind
    {
      sockaddrUn.ref.sun_family = winsock2.AF_UNIX;

      final String path = address.address;
      final List<int> pathBytes = utf8.encode(path);
      if (pathBytes.length >= SOCKADDR_PATH_LENGTH - 1) {
        throw ArgumentError('Socket path is too long');
      }

      for (int i = 0; i < pathBytes.length; i++) {
        sockaddrUn.ref.sun_path[i] = pathBytes[i];
      }
      sockaddrUn.ref.sun_path[pathBytes.length] = 0;

      final result = winsock2.bind(
          _socket, sockaddrUn.cast<winsock2.SOCKADDR>(), sizeOf<SOCKADDR_UN>());
      if (result == SOCKET_ERROR) {
        final errorCode = wsaGetLastError();
        final windowsException =
            WindowsException(HRESULT_FROM_WIN32(errorCode));
        if (errorCode == WSAEADDRINUSE) {
          throw io.SocketException(
            "Address already in use",
            osError: io.OSError(windowsException.toString(), errorCode),
            address: address,
          );
        }
        throw WindowsException(HRESULT_FROM_WIN32(errorCode));
      }
    }

    // Listen
    {
      final backlog = SOMAXCONN;
      final resultListen = winsock2.listen(_socket, backlog);
      if (resultListen == SOCKET_ERROR) {
        final errorCode = wsaGetLastError();
        throw WindowsException(HRESULT_FROM_WIN32(errorCode));
      }
    }

    // Set socket to non-blocking mode
    {
      final nonBlocking = calloc<Uint32>()..value = 1;
      final resultIoctl = winsock2.ioctlsocket(_socket, FIONBIO, nonBlocking);
      if (resultIoctl != WIN32_ERROR.NO_ERROR) {
        final errorCode = wsaGetLastError();
        throw WindowsException(HRESULT_FROM_WIN32(errorCode));
      }
      free(nonBlocking);
    }
    free(sockaddrUn);

    _startAcceptingConnections();
  }

  @override
  Future<io.ServerSocket> close() async {
    _stopAcceptingConnections();

    if (_socket != INVALID_SOCKET) {
      winsock2.closesocket(_socket);
    }

    if (_winsockInitialized) {
      _winsockInitialized = false;
    }

    await _controllerForNewConnections.close();
    return this;
  }

  @override
  StreamSubscription<io.Socket> listen(void Function(io.Socket event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controllerForNewConnections.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  bool _acceptingConnections = false;

  void _stopAcceptingConnections() {
    _acceptingConnections = false;
  }

  /// Starts accepting incoming socket connections asynchronously.
  void _startAcceptingConnections() {
    _acceptingConnections = true;
    unawaited(() async {
      while (_acceptingConnections) {
        final sockaddrUn = calloc<SOCKADDR_UN>();
        final addrlen = calloc<Int32>()..value = sizeOf<SOCKADDR_UN>();

        final clientSocket = winsock2.accept(
            _socket, sockaddrUn.cast<winsock2.SOCKADDR>(), addrlen);
        if (clientSocket == INVALID_SOCKET) {
          final errorCode = wsaGetLastError();
          if (errorCode == WSAEWOULDBLOCK ||
              errorCode == WIN32_ERROR.NO_ERROR) {
            free(sockaddrUn);
            free(addrlen);
            await Future<void>.delayed(const Duration(milliseconds: 300));
            continue;
          } else {
            free(sockaddrUn);
            free(addrlen);
            _controllerForNewConnections
                .addError(WindowsException(HRESULT_FROM_WIN32(errorCode)));
            break;
          }
        } else {
          final socket = SocketUdsWin(clientSocket);
          _controllerForNewConnections.add(socket);
          free(sockaddrUn);
          free(addrlen);
        }
      }
    }());
  }
}
