import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// バンドルされたアセットファイルについて、実行デバイス内でのパスを取得する。
///
/// 引数の [assetPath] で、バンドル元ファイルについての Package ルートからの相対パスを指定する。
///
/// 副作用: プラットフォームによっては、アセットデータを一時ファイルへ書き込む処理が行われる。
Future<String> getLocalAssetFilePath(String assetPath) async {
  // Desktop 環境ではバンドル内にファイルとして存在するはずなので、そのままアクセスできるはず
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    return normalize(absolute(assetPath));
  }
  // Mobile 環境では、一時ファイルにデータをコピーする必要がある。
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final file = File(join(tempDir.path, assetPath));
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}
