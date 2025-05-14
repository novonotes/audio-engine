import 'dart:io';

import 'package:test/test.dart';

final socketPath = "${Directory.systemTemp.path}/dart_io_test_socket";

void main() {
  test("dart:io does not support UDS on Windows", () async {
    if (Platform.isWindows) {
      try {
        await ServerSocket.bind(
          InternetAddress(socketPath, type: InternetAddressType.unix),
          0,
        );
        fail("Threw nothing.");
      } catch (e) {
        expect(e, isA<SocketException>());
        expect(
          e.toString(),
          contains(
            "Unix domain sockets are not available on this operating system.",
          ),
        );
      }
    } else {
      // Should throw nothing on other platforms.
      await ServerSocket.bind(
        InternetAddress(socketPath, type: InternetAddressType.unix),
        0,
      );
    }
  });
}
