import 'dart:io';

import 'package:path/path.dart';

/// UDS が用いる file を返す
/// Desktop 環境のみのサポート
Future<File> getUdsFile() async {
  final tempDir = await Directory.systemTemp.createTemp("novonotes_");
  final sockPath = join(
    tempDir.path,
    'engine.sock',
  );
  return File(sockPath);
}
