import 'dart:io';
import 'dart:math';
import 'package:nam/nam.dart';
import 'package:path/path.dart' as p;

import 'generated/helloworld.pb.dart' as pb;

void main() async {
  final client = await NamSocketClient.connect(
    InternetAddress(
      p.join(Directory.current.path, "tmp_uds.sock"),
      type: InternetAddressType.unix,
    ),
    4567,
  );
  final socket = client.socket;

  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  client.messagesFromServer.listen((message) {
    if (message.bodyType == pb.BodyType.HELLO_REPLY.value) {
      final decoded = pb.HelloReply.fromBuffer(message.body);
      print(
        "Received a message from server. Sessionid: ${message.sessionId}, contentType: ${message.bodyType}, content: ${decoded.writeToJson()}",
      );
    }
  });

  await Future<void>.delayed(const Duration(seconds: 2));

  final randomNumber = Random().nextInt(10);
  print("My name is Greeter Client #$randomNumber");
  final pbMessage = pb.HelloRequest(name: "Greeter Client #$randomNumber");

  // 2秒ごとに Server に message を送る
  while (true) {
    client.sendMessage(
      pb.BodyType.HELLO_REQUEST.value,
      pbMessage.writeToBuffer(),
      pb.Context().writeToBuffer(),
    );
    await Future<void>.delayed(const Duration(seconds: 2));
  }
}
