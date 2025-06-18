import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'audio_engine_method_channel.dart';

abstract class AudioEnginePlatform extends PlatformInterface {
  /// Constructs a AudioEnginePlatform.
  AudioEnginePlatform() : super(token: _token);

  static final Object _token = Object();

  static AudioEnginePlatform _instance = MethodChannelAudioEngine();

  /// The default instance of [AudioEnginePlatform] to use.
  ///
  /// Defaults to [MethodChannelAudioEngine].
  static AudioEnginePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AudioEnginePlatform] when
  /// they register themselves.
  static set instance(AudioEnginePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> getTopLevelWindowHandle() {
    throw UnimplementedError(
        'getTopLevelWindowHandle() has not been implemented.');
  }
}
