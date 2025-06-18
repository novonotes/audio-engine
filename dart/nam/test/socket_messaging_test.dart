import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:nam/src/client.dart';
import 'package:nam/src/connection.dart';
import 'package:nam/src/logger.dart';
import 'package:nam/src/server.dart';
import 'package:test/test.dart';
import 'package:uds_win/fs.dart' as fs;
import 'package:uds_win/uds_win.dart' as uds_win;

void main() {
  group(
    'Socket Messaging',
    () {
      enableLogging();
      late ServerSocket serverSocket;
      late File udsFile;

      setUp(() async {
        udsFile = File("socket_messaging_test.sock");
        await udsFile.parent.create(recursive: true);

        if (fs.existsSync(udsFile.path)) {
          fs.deleteSync(udsFile.path);
        }

        const port = 4567;
        final host = InternetAddress(
          udsFile.path,
          type: InternetAddressType.unix,
        );

        serverSocket = await uds_win.ServerSocket.bind(host, port);
        print("Server socket bound to: ${serverSocket.address}");
      });

      tearDown(() async {
        serverSocket.close();
      });

      test('Send and receive message.', () async {
        final server = NamSocketServer(
          serverSocket,
        );

        expect(
          fs.existsSync(udsFile.path),
          isTrue,
          reason: "UDS file should be created.",
        );
        print("UDS file exists: ${udsFile.path}");

        final connectionCompleter = Completer<NamSocketConnection>();

        final sub = server.connectionStream.listen((conn) {
          connectionCompleter.complete(conn);
        }, onError: (e) {
          connectionCompleter.completeError(e);
        });

        final client = await NamSocketClient.connect(
          InternetAddress(
            udsFile.path,
            type: InternetAddressType.unix,
          ),
          4567,
        );
        print("connecting...");

        final connection = await connectionCompleter.future.timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            throw TimeoutException("No Connection.");
          },
        );

        await client.ready.timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            throw TimeoutException("Client Not Ready.");
          },
        );

        connection.sendMessage(
          1,
          Uint8List.fromList([2]),
          Uint8List.fromList([3]),
        );

        var message = await client.messagesFromServer.first.timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            throw TimeoutException(
                "Client failed to receive message from server");
          },
        );

        expect(message.bodyType, 1);
        expect(message.body.first, 2);
        expect(message.context.first, 3);
        expect(message.sessionId, connection.sessionId);

        client.sendMessage(
          4,
          Uint8List.fromList([5, 6]),
          Uint8List.fromList([7, 8]),
        );

        message = await connection.messagesFromClient.first.timeout(
          const Duration(seconds: 1),
          onTimeout: () {
            throw TimeoutException(
                "Server failed to receive message from client");
          },
        );

        expect(message.bodyType, 4);
        expect(message.body[0], 5);
        expect(message.body[1], 6);
        expect(message.context[0], 7);
        expect(message.context[1], 8);
        expect(message.sessionId, connection.sessionId);

        await client.close();
        await sub.cancel();
      }, timeout: const Timeout(Duration(seconds: 10)));
    },
  );
}
