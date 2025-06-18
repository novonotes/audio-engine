import 'dart:io';

import 'package:audio_engine/foundation.dart';

void main(List<String> args) async {
  AudioEngineConfig.logging = true;
  final manager = EngineSessionManager();

  final udsPath = "${Directory.systemTemp.path}/uds_example_socket";

  print("UDS Path: $udsPath");

  await manager.startAcceptingOutProcessEngineUds(udsPath);
}
