import 'package:audio_engine/foundation.dart';

abstract class Logger {
  static void log(Object? object) {
    if (AudioEngineConfig.logging) {
      // ignore: avoid_print
      print(object);
    }
  }
}
