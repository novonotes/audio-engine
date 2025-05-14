import 'package:audio_engine_protoc_plugin/src/templates/body_type_template.dart';
import 'package:audio_engine_protoc_plugin/src/templates/controller_template.dart';
import 'package:audio_engine_protoc_plugin/src/templates/index_template.dart';
import 'package:path/path.dart';

import 'package:protoc_plugin/src/generated/plugin.pb.dart';

void generate(CodeGeneratorRequest request, CodeGeneratorResponse response) {
  for (final protoFile in request.protoFile) {
    if (protoFile.name.contains("body_type")) {
      final bodyTypeDartCode = generateBodyTypeDartCode(protoFile);
      response.file.add(
        CodeGeneratorResponse_File()
          ..name = withoutExtension(protoFile.name) + '.type.dart'
          ..content = bodyTypeDartCode,
      );
    } else if (protoFile.name.contains("novonotes/audio_engine")) {
      final controllerDartCode = generateControllerDartCode(protoFile);
      response.file.add(
        CodeGeneratorResponse_File()
          ..name = withoutExtension(protoFile.name) + '.controller.dart'
          ..content = controllerDartCode,
      );
    }
  }
  // Generating index.pb.dart and index.controller.dart
  {
    final fileNames = request.protoFile
        .map((f) => f.name)
        .where((name) => name.startsWith("novonotes/audio_engine"))
        .where((name) => !name.contains("body_type"));
    final versionDirNames = extractVersionDirNames(fileNames);
    for (final dir in versionDirNames) {
      final filesInDir = fileNames.where((name) => name.startsWith(dir));
      final indexPbDartCode =
          generateIndexDartCode(filesInDir, extension: ".pb.dart");
      response.file.add(
        CodeGeneratorResponse_File()
          ..name = join(dir, 'index.pb.dart')
          ..content = indexPbDartCode,
      );
      final indexControllerDartCode =
          generateIndexDartCode(filesInDir, extension: ".controller.dart");
      response.file.add(
        CodeGeneratorResponse_File()
          ..name = join(dir, 'index.controller.dart')
          ..content = indexControllerDartCode,
      );
    }
  }
  // Generating google/protobuf/index.pb.dart
  final indexPbDartCode = generateIndexDartCode(
    [
      "any",
      "duration",
      "empty",
      "field_mask",
      "struct",
      "timestamp",
    ],
    extension: ".pb.dart",
  );
  response.file.add(
    CodeGeneratorResponse_File()
      ..name = join("google/protobuf", 'index.pb.dart')
      ..content = indexPbDartCode,
  );
}

List<String> extractVersionDirNames(Iterable<String> filePaths) {
  // 最初の3つの部分を抽出し、Setでユニーク化
  final uniquePrefixes = filePaths
      .map((filePath) => filePath.split('/').take(3).join('/'))
      .toSet();

  // Setをリストに変換して返す
  return uniquePrefixes.toList();
}
