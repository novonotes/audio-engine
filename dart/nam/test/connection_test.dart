import 'dart:async';
import 'dart:io';

import 'package:nam/src/client.dart';
import 'package:nam/src/connection.dart';
import 'package:nam/src/logger.dart';
import 'package:nam/src/server.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';
import 'package:uds_win/fs.dart' as fs;
import 'package:uds_win/uds_win.dart' as uds_win;

void main() {
  group(
    'Socket Connection',
    () {
      Logger.enabled = true;
      late ServerSocket serverSocket;
      late File udsFile;

      setUp(() async {
        final sockPath = join(
          Directory.systemTemp.path,
          "novonotes",
          "nam_connection.sock",
        );
        udsFile = File(sockPath);
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

      test('Open and close client port 3 times', () async {
        final server = NamSocketServer(
          serverSocket,
        );

        expect(
          fs.existsSync(udsFile.path),
          isTrue,
          reason: "UDS file should be created.",
        );
        print("UDS file exists: ${udsFile.path}");

        final completers = [
          Completer<void>(),
          Completer<void>(),
          Completer<void>(),
        ];

        int closedConnectionCount = 0;
        server.connectionStream.listen((connection) async {
          connection.state.listen((newState) async {
            print("Connection state changed: $newState");
            if (newState == ConnectionState.disconnected) {
              completers[closedConnectionCount].complete(null);
              closedConnectionCount++;
            }
          });
        }, onError: (e) {
          completers[closedConnectionCount].completeError(e);
          closedConnectionCount++;
        });

        for (int i = 0; i < 3; i++) {
          print("-----------[Attempt ${i + 1}]-----------");
          final client = await NamSocketClient.connect(
            InternetAddress(
              udsFile.path,
              type: InternetAddressType.unix,
            ),
            4567,
          );

          await client.ready.timeout(
            Duration(seconds: 3),
            onTimeout: () => throw TimeoutException("Handshake failed."),
          );
          await client.close().timeout(
                Duration(seconds: 3),
                onTimeout: () =>
                    throw TimeoutException("Failed to close socket client."),
              );
          await completers[i].future.timeout(
                Duration(seconds: 3),
                onTimeout: () =>
                    throw TimeoutException("Completer Failed to complete."),
              );
        }
        expect(closedConnectionCount, 3);
      }, timeout: const Timeout(Duration(seconds: 20)));
    },
  );
}
