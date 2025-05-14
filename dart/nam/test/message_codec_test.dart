import 'dart:typed_data';

import 'package:nam/src/constants.dart';
import 'package:nam/src/message.dart';
import 'package:test/test.dart';

void main() {
  group('NAM Message Codec', () {
    test('converts Uint8List to Uint16', () {
      final buf = Uint8List(2);

      buf[0] = 0;
      buf[1] = 0;
      expect(getUint16FromUint8List(buf), 0);

      buf[0] = 0;
      buf[1] = 1;
      expect(getUint16FromUint8List(buf), 1);

      buf[0] = 1;
      buf[1] = 0;
      expect(getUint16FromUint8List(buf), 256);

      buf[0] = 1;
      buf[1] = 1;
      expect(getUint16FromUint8List(buf), 257);

      // uint16 の最大値
      buf[0] = 255;
      buf[1] = 255;
      expect(getUint16FromUint8List(buf), 65535);
    });
    test('converts Uint16 to Uint8List', () {
      var num = 0;
      expect(uint16ToUint8List(num), [0, 0]);

      num = 1;
      expect(uint16ToUint8List(num), [0, 1]);

      num = 256;
      expect(uint16ToUint8List(num), [1, 0]);

      num = 257;
      expect(uint16ToUint8List(num), [1, 1]);

      // uint16 の最大値
      num = 65535;
      expect(uint16ToUint8List(num), [255, 255]);
    });
    test('encodes header and body', () {
      expect(
        Message.from(
          sessionId: 0,
          bodyType: 0,
          context: Uint8List.fromList([0, 0]),
          body: Uint8List.fromList([0, 0]),
        ).buffer,
        [0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 0],
      );
      expect(
        Message.from(
          sessionId: 1,
          bodyType: uint16Max,
          context: Uint8List.fromList([8]),
          body: Uint8List.fromList([3, 5]),
        ).buffer,
        [0, 0, 1, 255, 255, 0, 0, 0, 1, 0, 0, 0, 2, 8, 3, 5],
      );
      expect(
        Message.from(
          sessionId: 1,
          bodyType: 256,
          body: Uint8List.fromList([3, 4, 5]),
          context: Uint8List.fromList([]),
        ).buffer,
        [0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 4, 5],
      );
    });
    test('decodes message', () {
      var message = Message(
          Uint8List.fromList([0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 4, 5]));
      // Header
      expect(message.version, 0);
      expect(message.sessionId, 1);
      expect(message.bodyType, 256);
      expect(message.contextSize, 0);
      expect(message.bodySize, 3);
      expect(message.context, isEmpty);
      // Body
      expect(message.body, [3, 4, 5]);
    });
  });
}
