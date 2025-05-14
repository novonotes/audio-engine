import 'dart:io';

import 'package:audio_engine/test_utils.dart';
import 'package:audio_engine/v1alpha1.dart' as ae;
import 'package:audio_engine_example/scenario/utils.dart';
import 'package:audio_engine_example/udp/datagram_stream.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nam/nam.dart' as nam;

/// RtSession によって Playhead Position の Stream を受け取るシナリオ。
/// Stream 開始から一秒間待って、30個程度の正しい Playhead Position のデータを受け取ったことを検証する。
class PlayheadPositionStreamScenario implements Scenario {
  final ae.RtSessionController rtSessionController;
  final ae.TransportController transportControlController;

  PlayheadPositionStreamScenario(
    ae.EngineMessageChannel channel,
  )   : rtSessionController = ae.RtSessionController(channel),
        transportControlController = ae.TransportController(channel);

  static const name = "Playhead Position Stream";

  @override
  Future<void> tearDown() async {
    await rtSessionController.dispose();
    await transportControlController.dispose();
  }

  @override
  Future<void> run(ExpectFunc expect) async {
    // Arrange
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    final port = socket.port;
    final List<ae.RtStateFragment> received = [];

    // Act
    {
      const rtSessionId = 1;
      await transportControlController.startPlayback(ae.StartPlaybackRequest());
      await rtSessionController.startRtSession(ae.StartRtSessionRequest(
        stateReceiverUri: "udp://localhost:$port",
        rtSessionId: rtSessionId,
      ));
      await transportControlController.startPlayheadPositionStream(
          ae.StartPlayheadPositionStreamRequest(rtSessionId: rtSessionId));
      // メッセージの受信処理
      socket.datagramStream.listen((datagram) {
        final message = nam.Message(datagram.data);
        final state = ae.RtStateFragment.fromBuffer(message.body);
        print(
            'Received RtStateFragment: ${state.toProto3Json()} from ${datagram.address.address}:${datagram.port}');
        received.add(state);
      });
      await Future<void>.delayed(const Duration(seconds: 1));
      await transportControlController
          .stopPlayheadPositionStream(ae.StopPlayheadPositionStreamRequest(
        rtSessionId: rtSessionId,
      ));
      await rtSessionController.stopRtSession(ae.StopRtSessionRequest(
        rtSessionId: rtSessionId,
      ));
      print('${received.length} message received.');
    }

    // Assert
    {
      // Rate 30 で1秒待ったので、 30 個前後受け取ったはず。
      expect(received.length, greaterThan(20));
      expect(received.length, lessThan(40));
      for (int i = 1; i < received.length; i++) {
        // Transport 再生中なのでひとつ前の position より大きい値になっているはず。
        expect(
          received[i].getPlayheadPosition(),
          greaterThan(received[i - 1].getPlayheadPosition()),
        );
      }
    }
  }
}

extension GetPositionPPQ on ae.RtStateFragment {
  double getPlayheadPosition() {
    final playhead = entitySubset
        .firstWhere(
          (entity) =>
              entity.whichType() ==
              ae.RtStateFragment_EngineEntity_Type.playhead,
        )
        .playhead;
    return playhead.positionPpq;
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
    await runFullScenario(PlayheadPositionStreamScenario(engine.channel));
  } finally {
    await manager.dispose();
  }
}
