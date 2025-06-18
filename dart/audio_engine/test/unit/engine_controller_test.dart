import 'dart:async';

import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<e.EngineMessageChannel>()])
import 'engine_controller_test.mocks.dart';

void main() {
  e.AudioEngineConfig.logging = true;
  group('EngineController Timeout Option Test', () {
    test('Test createAudioTrack with 10ms timeout', () async {
      final port = MockEngineMessageChannel();
      final controller = e.TrackController(port);

      try {
        await controller.createTrack(
          e.CreateTrackRequest(
            track: e.Track(
              id: '123',
              type: e.Track_TrackType.TRACK_TYPE_AUDIO,
            ),
          ),
          timeout: const Duration(milliseconds: 10),
        );
        fail('この行は実行されるべきではない');
      } catch (e) {
        expect(e, isInstanceOf<TimeoutException>());
      }
    });
    test('Test createAudioTrack with null timeout', () async {
      // このテストでは、timeout引数にnullを指定して、200ms 待ってもタイムアウトしたり、Response で解決したりしないことを確認
      final port = MockEngineMessageChannel();
      final controller = e.TrackController(port);

      // タイムアウトを設定しない
      final futureReq = controller.createTrack(e.CreateTrackRequest(
        track: e.Track(
          id: '123',
          type: e.Track_TrackType.TRACK_TYPE_AUDIO,
        ),
      ));

      final futureDelay = Future<e.CreateTrackResponse?>.delayed(
          const Duration(milliseconds: 200), () => null);

      final result = await Future.any([futureReq, futureDelay]);

      // null は、200 ms たってもまだ futureReq が解決していないことを示す
      expect(result, isNull);
    });
  });
}
