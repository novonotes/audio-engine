import 'dart:io';
import 'package:uds_win/uds_win.dart' as uds_win;
import 'package:uds_win/fs.dart' as fs;

final socketPath = "${Directory.systemTemp.path}/uds_win_example_socket";

void main() async {
  // Delete existing socket file if it exists
  if (fs.existsSync(socketPath)) {
    fs.deleteSync(socketPath);
  }

  // Create server socket
  final server = await uds_win.ServerSocket.bind(
    InternetAddress(socketPath, type: InternetAddressType.unix),
    0,
  );

  print('Server started: $socketPath');

  // Wait for connections
  server.listen((Socket client) {
    print('Client connected');
    client.listen((data) {
      print('Received from client: ${String.fromCharCodes(data)}');
      client.write('Hello, Client!');
    }, onDone: () {
      print('Client disconnected');
      client.close();
    });
  });
}
