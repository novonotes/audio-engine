import 'dart:io';

import 'package:path/path.dart';

/// UDS が用いる file を返す
/// Desktop 環境のみのサポート
Future<File> getUdsFile() async {
  // flutter に依存しない cli を作成するときも使いたいので、path_provider に依存しないように書いている
  final sockPath = join(
    await Directory.systemTemp.absolute.resolveSymbolicLinks(),
    'nam_$pid.sock',
  );
  return File(sockPath);
}
