import 'dart:math';
import 'dart:io';
import 'package:nam/nam.dart';
import 'package:path/path.dart' as p;

import 'generated/helloworld.pb.dart' as pb;

void main() async {
  final filePath = p.join(Directory.current.path, "tmp_uds.sock");

  final file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }

  const port = 4567;
  final host = InternetAddress(
    filePath,
    type: InternetAddressType.unix,
  );

  final socket = await ServerSocket.bind(host, port);
  final server = NamSocketServer(
    socket,
  );

  final randomNumber = Random().nextInt(10);
  final serverName = "Greeter Server #$randomNumber";
  print("My name is $serverName");

  server.connectionStream.listen((connection) async {
    connection.messagesFromClient.listen((msg) {
      final content = msg.body;
      final contentType = msg.bodyType;
      if (contentType == pb.BodyType.HELLO_REQUEST.value) {
        final decoded = pb.HelloRequest.fromBuffer(content);
        print(
          "received a message from client. sessionid: ${connection.sessionId}, content_type: $contentType, content: ${decoded.writeToJson()}",
        );
        final pbMessage = pb.HelloReply(
            message: "Hello ${decoded.name}. My name is $serverName");
        connection.sendMessage(
          pb.BodyType.HELLO_REPLY.value,
          pbMessage.writeToBuffer(),
          pb.Context().writeToBuffer(),
        );
      }
    });
  });
}
