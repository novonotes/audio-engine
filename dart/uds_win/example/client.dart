import 'dart:io';
import 'package:uds_win/uds_win.dart' as uds_win;

final socketPath = "${Directory.systemTemp.path}/uds_win_example_socket";

void main() async {
  // Connect to the server
  final socket = await uds_win.Socket.connect(
      InternetAddress(socketPath, type: InternetAddressType.unix), 0);

  print('Connected to the server');

  // Send data
  socket.write('Hello, Server!');

  // Wait for response from the server
  socket.listen((data) {
    print('Response from server: ${String.fromCharCodes(data)}');
    socket.close();
  }, onDone: () {
    print('Connection closed');
  });
}
