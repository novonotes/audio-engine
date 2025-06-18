import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:flutter/material.dart';
import 'package:audio_engine/test_utils.dart';

import '../../utils.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyWidgetsBindingObserver extends WidgetsBindingObserver {
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    print("didRequestAppExit");
    return AppExitResponse.exit;
  }
}

class MyAppState extends State<MyApp> {
  bool _isEngineReady = false;
  late e.EngineSessionManager _engineManager;
  late e.EngineSession _engine;
  late e.TrackController _trackController;
  late e.AudioRegionController _regionController;
  late e.TransportController _transportController;
  late e.ConnectionController _connectionController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(MyWidgetsBindingObserver());

    unawaited(() async {
      print("Initializing Audio Engine...");
      await _initEngine();
      print("Initialization finished.");

      setState(() {
        _isEngineReady = true;
      });
    }());
  }

  @override
  Future<void> dispose() async {
    print("dispose");
    final managementController = e.EngineManagementController(_engine.channel);
    await managementController.shutdown(e.ShutdownRequest());
    await _engineManager.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: !_isEngineReady
                  ? const Text("Initializing Audio Engine...")
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            print("start button is pressed");
                            await _transportController.updateTransport(
                              e.UpdateTransportRequest(
                                transport: e.Transport(playheadPosition: 0),
                                updateMask: e.FieldMask(
                                  paths: ['playhead_position'],
                                ),
                              ),
                            );
                            await _transportController
                                .startPlayback(e.StartPlaybackRequest());
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Start',
                              textDirection: TextDirection.ltr),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () async {
                            print("stop button is pressed");
                            await _transportController
                                .stopPlayback(e.StopPlaybackRequest());
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Stop',
                              textDirection: TextDirection.ltr),
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
  Future<void> _initEngine() async {
    _engineManager = e.EngineSessionManager();
    _engine = await _engineManager.startInProcessAudioEngine(
      Platform.isIOS ? null : await getAudioEngineLibraryPath(),
    );
    print("Engine initialized");

    _trackController = e.TrackController(_engine.channel);
    _regionController = e.AudioRegionController(_engine.channel);
    _transportController = e.TransportController(_engine.channel);
    _connectionController = e.ConnectionController(_engine.channel);

    const trackId = '123';
    await _trackController.createTrack(e.CreateTrackRequest(
      track: e.Track(
        id: trackId,
        type: e.Track_TrackType.TRACK_TYPE_AUDIO,
      ),
    ));

    final filePath = await getLocalAssetFilePath("assets/example.wav");

    await _connectionController.connect(e.ConnectRequest(
      connection: e.Connection(
        srcAudioTrackId: trackId,
        destAudioOutput: e.Empty(),
      ),
    ));

    await _regionController.createAudioRegion(e.CreateAudioRegionRequest(
      parentId: trackId,
      audioRegion: e.AudioRegion(
        sourceFilePath: filePath,
        position: 0,
        duration: 128,
      ),
    ));
  }
}
