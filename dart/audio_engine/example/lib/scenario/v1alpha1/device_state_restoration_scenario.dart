import 'dart:io';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:audio_engine_example/tracktion_internal_device_type_ids.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class DeviceStateRestorationScenario implements Scenario {
  final ae.DeviceInstanceController deviceInstanceController;

  DeviceStateRestorationScenario(
    ae.EngineMessageChannel channel,
  ) : deviceInstanceController = ae.DeviceInstanceController(channel);

  static const name = "Device State Restoration";

  @override
  Future<void> tearDown() async {
    await deviceInstanceController.dispose();
  }

  @override
  Future<void> run(ExpectFunc expect) async {
    const deviceInstanceId = 'device-instance-1';
    const volumeParamId = "volume";
    String stateRestorationToken = '';
    // Device の作成
    {
      await deviceInstanceController
          .createDeviceInstance(ae.CreateDeviceInstanceRequest(
        deviceInstance: ae.DeviceInstance(
          id: deviceInstanceId,
          deviceTypeId: TracktionInternalDeviceTypeIds.volumeAndPan,
        ),
      ));
    }

    // volume パラメーターを 0dB に設定し、State Restoration Token を保存
    {
      await deviceInstanceController.setParameterValue(
        ae.SetParameterValueRequest(
          deviceInstanceId: deviceInstanceId,
          parameterId: volumeParamId,
          textValue: "0 dB",
        ),
      );
      final res = await deviceInstanceController.getDeviceInstance(
        ae.GetDeviceInstanceRequest(
          deviceInstanceId: deviceInstanceId,
        ),
      );
      expect(res.deviceInstance.id, deviceInstanceId);
      expect(res.deviceInstance.parameters[volumeParamId]?.currentValue,
          "+0.00 dB");
      // State Restoration Token を保存
      stateRestorationToken = res.deviceInstance.stateRestorationToken;
    }

    // -6dB に変更
    {
      await deviceInstanceController.setParameterValue(
        ae.SetParameterValueRequest(
          deviceInstanceId: deviceInstanceId,
          parameterId: volumeParamId,
          textValue: "-6 dB",
        ),
      );
      final res3 = await deviceInstanceController.getDeviceInstance(
        ae.GetDeviceInstanceRequest(
          deviceInstanceId: deviceInstanceId,
        ),
      );
      expect(res3.deviceInstance.parameters[volumeParamId]?.currentValue,
          "-6.00 dB");
    }

    // 0dB の時点の状態を復元
    {
      await deviceInstanceController.restoreDeviceInstanceState(
        ae.RestoreDeviceInstanceStateRequest(
          deviceInstanceId: deviceInstanceId,
          stateRestorationToken: stateRestorationToken,
        ),
      );
      final res4 = await deviceInstanceController.getDeviceInstance(
        ae.GetDeviceInstanceRequest(
          deviceInstanceId: deviceInstanceId,
        ),
      );
      expect(res4.deviceInstance.parameters[volumeParamId]?.currentValue,
          "+0.00 dB");
      expect(res4.deviceInstance.stateRestorationToken, stateRestorationToken);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ae.AudioEngineConfig.logging = true;
  print("CWD: ${Directory.current.path}");
  final manager = ae.EngineSessionManager();
  try {
    final dllPath =
        await getAudioEngineLibraryPath(audioEngineRootPath: "../../..");

    ae.EngineSession? engine;
    try {
      engine = await manager.startInProcessAudioEngine(dllPath);
    } catch (e) {
      print("Failed to launch InProcessAudioEngine: $e");
      rethrow;
    }
    await runFullScenario(DeviceStateRestorationScenario(engine.channel));
  } finally {
    await manager.dispose();
  }
}
