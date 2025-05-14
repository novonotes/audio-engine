import 'dart:io';
import 'dart:typed_data';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:nam/nam.dart' as nam;

void main() async {
  // 送信先のIPアドレスとポート番号
  final address = InternetAddress('127.0.0.1');
  const port = 8081;

  // UDPソケットの作成
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  print('Sender address is ${socket.address.address}:${socket.port}');

  print('Sending message to ${address.address}:$port');

  // メッセージ送信
  for (var i = 0; i < 10; i++) {
    final command = ae.RtCommandBatch_Command()
      ..updateParameter =
          ae.RtUpdateParameterCommand(normalizedValue: 0.123 + i);

    final batch = ae.RtCommandBatch(commands: [command]);
    final namMessage = nam.Message.from(
      sessionId: 32,
      body: batch.writeToBuffer(),
      bodyType: 101,
      context: Uint8List(0),
    );
    socket.send(namMessage.buffer, address, port);
    print('Message sent: ${batch.toProto3Json()}');
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  socket.close();
  print('Closed');
}
