import 'dart:io';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:audio_engine_example/udp/datagram_stream.dart';

void main() async {
  // 受信するポート番号
  const port = 8080;

  // UDPソケットの作成
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);

  print('Listening on port $port');

  // メッセージの受信処理
  socket.datagramStream.listen((datagram) {
    final message = ae.RtStateFragment.fromBuffer(datagram.data);
    print(
        'Received message: ${message.toProto3Json()} from ${datagram.address.address}:${datagram.port}');
  });
}
