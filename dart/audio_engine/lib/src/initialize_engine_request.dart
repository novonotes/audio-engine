import 'dart:io';

import 'package:audio_engine/src/engine_session.dart';
import 'package:audio_engine/src/engine_message_channel.dart';
import 'package:audio_engine/src/generated/novonotes/audio_engine/v1alpha1/engine_management.controller.dart'
    as v1alpha1;
import 'generated/novonotes/audio_engine/v1alpha1/engine_management.pb.dart'
    as v1alpha1;

Future<NativeEngineRuntimeMetadata> initializeEngineRequest(
    EngineMessageChannel channel) async {
  try {
    return await initializeEngineRequestV1Alpha1(channel);
  } catch (e) {
    throw Exception("The client does not support v1alpha1 API: $e");
  }
}

Future<NativeEngineRuntimeMetadata> initializeEngineRequestV1Alpha1(
    EngineMessageChannel channel) async {
  final controller = v1alpha1.EngineManagementController(channel);
  try {
    final res = await controller.initialize(
      v1alpha1.InitializeRequest(
        appInstanceId: "$pid",
        schemaVersion: "v1alpha1",
      ),
      timeout: const Duration(seconds: 10),
    );
    return NativeEngineRuntimeMetadata(
      engineTypeId: res.engineTypeId,
      displayName: res.displayName,
      schemaVersion: res.schemaVersion,
      pid: res.pid,
    );
  } finally {
    await controller.dispose();
  }
}
