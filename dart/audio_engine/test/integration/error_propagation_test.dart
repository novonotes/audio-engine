import 'package:audio_engine/src/in_process_engine/in_process_engine.dart';
import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test("Error propagation test", () async {
    final engine = InProcessEngine(
      await getAudioEngineLibraryPath(),
      NamSessionManager(),
    );
    await engine.initialize();
    final controller = DeviceInstanceController(engine);
    try {
      await controller.deleteDeviceInstance(DeleteDeviceInstanceRequest(
        deviceInstanceId: 'invalid-id',
      ));
      fail("Expected an error to be thrown");
    } catch (e, s) {
      expect(e, isA<NativeEngineError>());
      expect(
        s.toString(),
        contains("deleteDeviceInstance"),
        reason: "呼び出し元の関数名を含むべき",
      );
    }
  });
}
