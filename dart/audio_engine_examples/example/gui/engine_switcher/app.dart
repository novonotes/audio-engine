import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:audio_engine/v1alpha1.dart' as e;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nam/nam.dart' as nam;

import '../../utils.dart';

final engineSessionManager = e.EngineSessionManager();

void main() async {
  e.AudioEngineConfig.logging = true;
  nam.enableLogging();
  var app = const MyApp();
  runApp(app);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyWidgetsBindingObserver extends WidgetsBindingObserver {
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    print("requestAppExit");
    await engineSessionManager.dispose();
    return AppExitResponse.exit;
  }
}

class MyAppState extends State<MyApp> {
  String? inProcessEngineDllPath;
  String? audioEngineServiceExecutablePath;
  bool get _pathsAvailable =>
      inProcessEngineDllPath != null &&
      audioEngineServiceExecutablePath != null;
  List<e.EngineSession> _engines = [];
  StreamSubscription<void>? _subscription1;
  StreamSubscription<void>? _subscription2;

  bool disableLaunchButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(MyWidgetsBindingObserver());
    _subscription1 =
        engineSessionManager.sessionAddedStream.listen((engine) async {
      await _setupArrangementAndStudio(engine);
      setState(() {
        _engines = engineSessionManager.listAllEngines();
      });
    });
    _subscription2 = engineSessionManager.sessionRemovedStream.listen((event) {
      setState(() {
        _engines = engineSessionManager.listAllEngines();
      });
    });
  }

  @override
  Future<void> dispose() async {
    await _subscription1?.cancel();
    await _subscription2?.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: _pathsAvailable == false
              ? PathSetting(onOkPressed: (
                  String inProcessDllPath,
                  String audioEngineServiceExecutablePath,
                ) {
                  unawaited(() async {
                    setState(() {
                      inProcessEngineDllPath = inProcessDllPath;
                      audioEngineServiceExecutablePath =
                          audioEngineServiceExecutablePath;
                      disableLaunchButton = true;
                    });
                    await _launchServer();
                    setState(() {
                      disableLaunchButton = false;
                    });
                  }());
                })
              : Column(
                  children: [
                    TextButton(
                      onPressed: disableLaunchButton
                          ? null
                          : () async {
                              setState(() {
                                disableLaunchButton = true;
                              });
                              engineSessionManager.startInProcessAudioEngine(
                                  inProcessEngineDllPath!);
                              setState(() {
                                disableLaunchButton = false;
                              });
                            },
                      child: const Text('Launch In-process Engine'),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: disableLaunchButton
                          ? null
                          : () async {
                              setState(() {
                                disableLaunchButton = true;
                              });
                              await engineSessionManager
                                  .startSubprocessAudioEngine(
                                audioEngineServiceExecutablePath!,
                              );
                              setState(() {
                                disableLaunchButton = false;
                              });
                            },
                      child: const Text('Launch Audio Engine Service'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (final controller in _engines)
                          EngineInstanceWidget(session: controller)
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _launchServer() async {
    final path = absolute("uds");
    print("UDS file: $path");

    // 既存のUDSファイルがあれば削除
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }

    await engineSessionManager.startAcceptingOutProcessEngineUds(path);
  }

  Future<void> _setupArrangementAndStudio(e.EngineSession engine) async {
    final trackController = e.TrackController(engine.channel);
    final regionController = e.AudioRegionController(engine.channel);
    final connectionController = e.ConnectionController(engine.channel);

    try {
      const trackId = '123';
      await trackController.createTrack(e.CreateTrackRequest(
        track: e.Track(
          id: trackId,
          type: e.Track_TrackType.TRACK_TYPE_AUDIO,
        ),
      ));
      print("AudioTrackId: $trackId");

      await regionController.createAudioRegion(e.CreateAudioRegionRequest(
        parentId: trackId,
        audioRegion: e.AudioRegion(
          sourceFilePath: await getLocalAssetFilePath("assets/example.wav"),
          position: 0,
          duration: 64,
        ),
      ));

      await connectionController.connect(e.ConnectRequest(
        connection: e.Connection(
          srcAudioTrackId: trackId,
          destAudioOutput: e.Empty(),
        ),
      ));
    } finally {
      await trackController.dispose();
      await regionController.dispose();
      await connectionController.dispose();
    }
  }
}

class EngineInstanceWidget extends StatelessWidget {
  final e.EngineSession session;
  const EngineInstanceWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("engineTypeId: ${session.nativeEngine.engineTypeId}"),
          Text("displayName: ${session.nativeEngine.displayName}"),
          Text("schemaVersion: ${session.nativeEngine.schemaVersion}"),
          Text("pid: ${session.nativeEngine.pid}"),
          TextButton(
            onPressed: () async {
              print("start button is pressed");
              final controller = e.TransportController(session.channel);
              await controller.startPlayback(e.StartPlaybackRequest());
              await controller.dispose();
            },
            child: const Text('Start'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              print("stop button is pressed");
              final controller = e.TransportController(session.channel);
              await controller.stopPlayback(e.StopPlaybackRequest());
              await controller.dispose();
            },
            child: const Text('Stop'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              print("shutdown button is pressed");
              engineSessionManager.endSession(session.sessionId);
            },
            child: const Text('Shutdown'),
          ),
        ],
      ),
    );
  }
}

class PathSetting extends StatefulWidget {
  final void Function(
    String inProcessDllPath,
    String audioEngineServiceExecutablePath,
  ) onOkPressed;

  const PathSetting({super.key, required this.onOkPressed});

  @override
  PathSettingState createState() => PathSettingState();
}

class PathSettingState extends State<PathSetting> {
  TextEditingController inProcessDllPathController =
      TextEditingController(text: "");
  TextEditingController audioEngineServiceExecutablePathController =
      TextEditingController(text: "");

  @override
  void initState() {
    unawaited(() async {
      final prefs = await SharedPreferences.getInstance();
      final inProcessPathPref = prefs.getString("inProcessDllPath");
      if (inProcessPathPref != null) {
        inProcessDllPathController.text = inProcessPathPref;
      }
      final audioEngineServicePathPref =
          prefs.getString("audioEngineServiceExecutablePath");
      if (audioEngineServicePathPref != null) {
        audioEngineServiceExecutablePathController.text =
            audioEngineServicePathPref;
      }
    }());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: inProcessDllPathController,
          decoration:
              const InputDecoration(labelText: 'In-process Engine DLL Path'),
        ),
        TextFormField(
          controller: audioEngineServiceExecutablePathController,
          decoration: const InputDecoration(
              labelText: 'Audio Engine Service Executable Path'),
        ),
        const SizedBox(height: 20), // スペーサー
        ElevatedButton(
          onPressed: () async {
            // OKボタンが押されたときにコールバックを呼び出し、2つのパスを伝える
            widget.onOkPressed(
              inProcessDllPathController.text,
              audioEngineServiceExecutablePathController.text,
            );
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
              "inProcessDllPath",
              inProcessDllPathController.text,
            );
            await prefs.setString(
              "audioEngineServiceExecutablePath",
              audioEngineServiceExecutablePathController.text,
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
