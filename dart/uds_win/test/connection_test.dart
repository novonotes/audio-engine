import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:uds_win/fs.dart' as fs;
import 'package:uds_win/uds_win.dart' as uds_win;

void main() {
  group(
    'Connection Test',
    () {
      late ServerSocket serverSocket;
      late File udsFile;

      setUp(() async {
        final sockPath = "${Directory.systemTemp.path}/uds_win_conn/test.sock";
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
        try {
          if (fs.existsSync(udsFile.path)) {
            fs.deleteSync(udsFile.path);
          }
        } on FileSystemException catch (e) {
          // OS Error: No such file or directory (errno: 2) の場合はファイルが既に削除されているため無視
          if (e.osError?.errorCode == 2) {
            print("UDSファイルは既に削除されています: ${udsFile.path}");
          } else {
            rethrow;
          }
        }
      });

      test(
        'Open and close client port',
        () async {
          expect(
            fs.existsSync(udsFile.path),
            isTrue,
            reason: "UDS file should be created.",
          );
          print("UDS file exists: ${udsFile.path}");

          final completers = [
            Completer<void>(),
            Completer<void>(),
            Completer<void>()
          ];

          int closedConnectionCount = 0;
          serverSocket.listen(
            (connection) async {
              connection.listen(
                (mes) async {},
                onDone: () async {
                  completers[closedConnectionCount].complete(null);
                  print("Client closed connection. $closedConnectionCount");
                  closedConnectionCount++;
                },
                onError: (e) {
                  completers[closedConnectionCount].completeError(e);
                  closedConnectionCount++;
                },
              );
            },
            onError: (e) {
              print(e);
              throw e;
            },
          );

          for (int i = 0; i < 3; i++) {
            final clientSocket = await uds_win.Socket.connect(
              InternetAddress(
                udsFile.path,
                type: InternetAddressType.unix,
              ),
              0,
            );
            await clientSocket.close();
            await completers[i].future;
          }
          expect(closedConnectionCount, equals(3));
        },
        timeout: const Timeout(Duration(seconds: 1000)),
      );
    },
  );
}
