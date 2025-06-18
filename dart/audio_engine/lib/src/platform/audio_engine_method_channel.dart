import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'audio_engine_platform_interface.dart';

/// An implementation of [AudioEnginePlatform] that uses method channels.
class MethodChannelAudioEngine extends AudioEnginePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('audio_engine');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getTopLevelWindowHandle() async {
    if (!Platform.isWindows) {
      return null;
    }
    try {
      final windowHandle =
          await methodChannel.invokeMethod<int>('getTopLevelWindowHandle');
      return windowHandle;
    } on MissingPluginException {
      return null;
    }
  }
}
