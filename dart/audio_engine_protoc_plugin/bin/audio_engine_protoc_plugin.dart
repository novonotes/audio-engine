import 'dart:io';
import 'dart:typed_data';

import 'package:audio_engine_protoc_plugin/audio_engine_protoc_plugin.dart';
import 'package:fixnum/fixnum.dart';
import 'package:protoc_plugin/src/generated/plugin.pb.dart';

void main(List<String> args) async {
  await stdin
      .fold(BytesBuilder(), (BytesBuilder builder, data) => builder..add(data))
      .then((builder) => builder.takeBytes())
      .then((List<int> bytes) {
    final request = CodeGeneratorRequest.fromBuffer(bytes);
    final response = CodeGeneratorResponse();

    generate(request, response);

    response.supportedFeatures =
        Int64(CodeGeneratorResponse_Feature.FEATURE_PROTO3_OPTIONAL.value);

    stdout.add(response.writeToBuffer());
    stdout.close();
  });
}
