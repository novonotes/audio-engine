import 'dart:io';

import 'package:test/test.dart';
import 'package:uds_win/src/bindings.dart';

void main() {
  test("WSAGetLastError", () async {
    if (Platform.isWindows) {
      final errorCode = wsaGetLastError();
      expect(errorCode, 0);
    }
  });
}
