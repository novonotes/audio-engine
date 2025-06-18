abstract class Logger {
  static bool enabled = false;
  static void log(Object? object) {
    if (enabled) {
      // ignore: avoid_print
      print(object);
    }
  }
}

void enableLogging() {
  Logger.enabled = true;
}
