import 'package:audio_engine/src/constants.dart';
import 'package:audio_engine/src/generated/novonotes/audio_engine/v1alpha1/engine_management.controller.dart'
    as v1alpha1;
import 'package:audio_engine/v1alpha1.dart';

Future<void> shutdownEngineRequest(
    EngineMessageChannel channel, String schemaVersion) async {
  if (schemaVersion == VersionNumber.v1alpha1) {
    final controller = v1alpha1.EngineManagementController(channel);
    try {
      await controller.shutdown(ShutdownRequest());
    } finally {
      await controller.dispose();
    }
    return;
  }
  throw UnsupportedError("Unsupported schema version: $schemaVersion");
}
