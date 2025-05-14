import 'dart:io';
import 'package:test/test.dart';
import 'package:uds_win/fs.dart' as fs;
import 'package:uds_win/uds_win.dart' as uds_win;

final socketPath = "${Directory.systemTemp.path}/uds_win_test_socket";

void main() {
  group(
    'Unix Domain Socket Test',
    () {
      late ServerSocket server;
      late Socket clientSocket;

      final List<String> messagesFromClient = [];
      int clientCount = 0;

      setUp(() async {
        // Ensure no leftover socket file exists
        print("socketPath: $socketPath");
        if (fs.existsSync(socketPath)) {
          fs.deleteSync(socketPath);
        }

        // Start the server
        server = await uds_win.ServerSocket.bind(
          InternetAddress(socketPath, type: InternetAddressType.unix),
          0,
        );

        server.listen((client) {
          clientCount++;
          client.listen((data) {
            final mes = String.fromCharCodes(data);
            messagesFromClient.add(mes);
            print('Server received: $mes');
            client.write('Hello from server');
          }, onError: (e, s) {
            print("Server socket error: $e");
            print(s);
            throw e;
          });
        }, onError: (e, s) {
          print("Server socket connection error: $e");
          print(s);
          throw e;
        });
      });

      tearDown(() async {
        messagesFromClient.clear();
        await server.close();
        if (fs.existsSync(socketPath)) {
          fs.deleteSync(socketPath);
        }
      });

      test('Client can send and receive messages from the server', () async {
        // Connect the client to the server
        clientSocket = await uds_win.Socket.connect(
          InternetAddress(socketPath, type: InternetAddressType.unix),
          0,
        );

        // Listen to server responses
        final messagesFromServer = <String>[];
        clientSocket.listen((data) {
          final mes = String.fromCharCodes(data);
          messagesFromServer.add(mes);
          print("Client received: $mes");
        }, onError: (e, s) {
          print("Client socket error: $e");
          print(s);
          throw e;
        });

        // Send a message from the client
        const clientMessage = 'Hello from client';
        clientSocket.write(clientMessage);

        // Allow time for communication
        await Future.delayed(Duration(seconds: 1));

        // Verify server's response
        expect(clientCount, equals(1));
        expect(messagesFromClient, hasLength(1));
        expect(messagesFromClient, contains('Hello from client'));
        expect(messagesFromServer, hasLength(1));
        expect(messagesFromServer, contains('Hello from server'));

        await clientSocket.close();
      });
    },
  );
}
