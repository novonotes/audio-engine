// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'dart:core';
import 'dart:typed_data';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:audio_engine_example/udp/datagram_stream.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart' as nam;

const bool verbose = false;
void printIfVerbose(Object? object) {
  if (verbose) {
    print(object);
  }
}

class ParameterSyncScenario implements Scenario {
  static const String TARGET_PARAMETER = 'volume';
  static const double EPSILON = 0.01; // 許容誤差を1%に設定

  final ae.RtSessionController rtSessionController;
  final ae.DeviceInstanceController deviceInstanceController;
  final ae.DeviceDescriptorController deviceDescriptorController;
  bool foundUpdating = false;
  bool foundFinalized = false;
  int updatingCount = 0; // UPDATING状態の受信回数
  int finalizedCount = 0; // FINALIZED状態の受信回数
  DateTime? lastUpdatingTime; // 最後にUPDATING状態を受信した時刻
  DateTime? lastFinalizedTime; // 最後にFINALIZED状態を受信した時刻

  // パラメーター値の確認用
  double? lastSetValue;
  double? lastReceivedModulatedValue;
  double? lastReceivedUnmodulatedValue;
  String? lastReceivedTextValue;

  // UDPソケットとコマンド受信先情報
  RawDatagramSocket? _udpSocket;
  int _commandReceiverPort = -1;
  String _commandReceiverAddress = 'invalid-address';

  ParameterSyncScenario(
    ae.EngineMessageChannel channel,
  )   : rtSessionController = ae.RtSessionController(channel),
        deviceInstanceController = ae.DeviceInstanceController(channel),
        deviceDescriptorController = ae.DeviceDescriptorController(channel);

  static const name = "Parameter Sync";

  @override
  Future<void> tearDown() async {
    _udpSocket?.close();
    await rtSessionController.dispose();
    await deviceInstanceController.dispose();
    await deviceDescriptorController.dispose();
  }

  // UDPを通じてRtCommandBatchを送信する
  Future<void> sendRtCommandBatch(
      int sessionId, ae.RtCommandBatch commandBatch) async {
    // メッセージをシリアライズ
    final bytes = commandBatch.writeToBuffer();

    // NAMメッセージを作成
    final message = nam.Message.from(
      sessionId: sessionId,
      bodyType: ae.BodyType.BODY_TYPE_RT_UPDATE_PARAMETER_COMMAND.value,
      context: Uint8List(0),
      body: bytes,
    );

    // UDPソケットが初期化されていない場合は作成
    _udpSocket ??= await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

    // UDPパケットを送信
    final targetAddress = InternetAddress(_commandReceiverAddress);
    _udpSocket!.send(message.buffer, targetAddress, _commandReceiverPort);
    print('UDP経由でRtCommandBatchを送信しました'
        ' (targetAddress=${targetAddress.address}, '
        'targetPort=$_commandReceiverPort, '
        'commandBatch=${commandBatch.toProto3Json()})');
  }

  // UpdateParameterコマンドを送信
  Future<void> sendUpdateParameterCommand(int sessionId, String deviceId,
      String parameterId, double normalizedValue) async {
    final command = ae.RtCommandBatch(
      commands: [
        ae.RtCommandBatch_Command(
          updateParameter: ae.RtUpdateParameterCommand(
            parameterSyncKey: '$deviceId:$parameterId',
            normalizedValue: normalizedValue,
          ),
        ),
      ],
    );

    await sendRtCommandBatch(sessionId, command);
  }

  // FinalizeParameterコマンドを送信
  Future<void> sendFinalizeParameterCommand(int sessionId, String deviceId,
      String parameterId, double normalizedValue) async {
    final command = ae.RtCommandBatch(
      commands: [
        ae.RtCommandBatch_Command(
          finalizeParameter: ae.RtFinalizeParameterCommand(
            parameterSyncKey: '$deviceId:$parameterId',
            normalizedValue: normalizedValue,
          ),
        ),
      ],
    );

    await sendRtCommandBatch(sessionId, command);
  }

  @override
  Future<void> run(ExpectFunc expect) async {
    // Arrange
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    final port = socket.port;
    final List<ae.RtStateFragment> received = [];

    const rtSessionId = 1;

    // デバイスの作成
    final createResponse = await deviceInstanceController.createDeviceInstance(
      ae.CreateDeviceInstanceRequest()
        ..deviceInstance = (ae.DeviceInstance()
          ..id = 'test-device'
          ..deviceTypeId = 'TracktionInternal-Volume and Pan-cfaae71a-0'),
    );

    // デバイスインスタンスの取得
    final getResponse = await deviceInstanceController.getDeviceInstance(
      ae.GetDeviceInstanceRequest()
        ..deviceInstanceId = createResponse.deviceInstance.id,
    );

    print('Device parameters: ${getResponse.deviceInstance.parameters}');

    // パラメーターが存在することを確認
    if (getResponse.deviceInstance.parameters.isEmpty) {
      throw Exception(
          'Device has no parameters: ${getResponse.deviceInstance.deviceTypeId}');
    }

    // RTセッションの開始
    final rtSessionResponse =
        await rtSessionController.startRtSession(ae.StartRtSessionRequest(
      stateReceiverUri: "udp://localhost:$port",
      rtSessionId: rtSessionId,
    ));

    // コマンド受信URLを解析
    final commandReceiverUriString = rtSessionResponse.commandReceiverUri;
    print('Command receiver URL: $commandReceiverUriString');
    final commandReceiverUri = Uri.parse(commandReceiverUriString);
    _commandReceiverPort = commandReceiverUri.port;
    _commandReceiverAddress = commandReceiverUri.host;
    print('Command receiver: $_commandReceiverAddress:$_commandReceiverPort');

    // メッセージの受信処理
    socket.datagramStream.listen((datagram) {
      final message = nam.Message(datagram.data);
      final state = ae.RtStateFragment.fromBuffer(message.body);
      printIfVerbose(
          'Received RtStateFragment: ${state.toProto3Json()} from ${datagram.address.address}:${datagram.port}');
      received.add(state);

      // 状態を確認
      for (final entity in state.entitySubset) {
        if (entity.hasParameter()) {
          final param = entity.parameter;
          if (param.parameterSyncKey == 'test-device:$TARGET_PARAMETER') {
            lastReceivedModulatedValue = param.normalizedModulatedValue;
            lastReceivedUnmodulatedValue = param.normalizedUnmodulatedValue;
            lastReceivedTextValue = param.textUnmodulatedValue;
            printIfVerbose(
                'パラメータ値を受信: modulated=${param.normalizedModulatedValue}, unmodulated=${param.normalizedUnmodulatedValue}, テキスト値=${param.textUnmodulatedValue}');

            if (param.state == ae.RtParameter_State.STATE_UPDATING) {
              foundUpdating = true;
              updatingCount++;
              lastUpdatingTime = DateTime.now();
              printIfVerbose(
                  'UPDATING state with value: ${param.normalizedUnmodulatedValue}');
            } else if (param.state == ae.RtParameter_State.STATE_FINALIZED) {
              foundFinalized = true;
              finalizedCount++;
              lastFinalizedTime = DateTime.now();
              printIfVerbose(
                  'FINALIZED state with value: ${param.normalizedUnmodulatedValue}');
            }
          }
        }
      }
    });

    // パラメーター同期の開始
    await deviceInstanceController.startParameterSync(
      ae.StartParameterSyncRequest(
        rtSessionId: rtSessionId,
        parameterSyncKeys: ['test-device:$TARGET_PARAMETER'],
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 500));

    // 初期状態は FINALIZED のはず。
    expect(finalizedCount > 0, true, reason: 'No FINALIZED states received');
    expect(updatingCount, isZero,
        reason: 'UPDATING states already received unexpectedly');

    // UDP経由でUpdateParameterコマンドを送信
    const testValue1 = 0.75; // 正規化された値（0.0〜1.0）
    await sendUpdateParameterCommand(
        rtSessionId, 'test-device', TARGET_PARAMETER, testValue1);

    await Future<void>.delayed(const Duration(milliseconds: 500));

    expect(updatingCount > 0, true, reason: 'No UPDATING states received');

    // 少し待ってレスポンスを確認
    await Future<void>.delayed(const Duration(milliseconds: 500));
    print('After update unmodulated value: $lastReceivedUnmodulatedValue');

    // 複数のアップデートを送信
    for (double i = 0.0; i < 1.0; i += 0.1) {
      await sendUpdateParameterCommand(
          rtSessionId, 'test-device', TARGET_PARAMETER, i);
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }

    // 最後にFinalizeコマンドを送信

    // 最終値。このシナリオが終わった時にこのパラメーター値になっているべき。
    const testValue2 = 0.85;
    await sendFinalizeParameterCommand(
        rtSessionId, 'test-device', TARGET_PARAMETER, testValue2);

    // レスポンスを待つ（1秒）
    await Future<void>.delayed(const Duration(milliseconds: 500));
    print('Final unmodulated value: $lastReceivedUnmodulatedValue');

    // パラメーター同期の停止
    await deviceInstanceController.stopParameterSync(
      ae.StopParameterSyncRequest(
        rtSessionId: rtSessionId,
        parameterSyncKeys: ['test-device:$TARGET_PARAMETER'],
      ),
    );

    // 最終確認
    await Future<void>.delayed(const Duration(milliseconds: 500));

    print('Final stats:');
    print('- UPDATING count: $updatingCount');
    print('- FINALIZED count: $finalizedCount');

    // 結果検証 - normalizedUnmodulatedValueを使用
    final testSuccessful = (lastReceivedUnmodulatedValue != null &&
        (lastReceivedUnmodulatedValue! - testValue2).abs() < EPSILON);
    expect(testSuccessful, true,
        reason:
            'Failed to set parameter value via UDP. Expected: $testValue2, Actual: $lastReceivedUnmodulatedValue');
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
    await runFullScenario(ParameterSyncScenario(engine.channel));
  } finally {
    await manager.dispose();
  }
}
