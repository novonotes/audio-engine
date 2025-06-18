import 'package:audio_engine/src/generated/novonotes/audio_engine/v1alpha1/type/engine_error.pb.dart'
    as v1alpha1;
import 'package:audio_engine/src/generated/google/rpc/code.pb.dart' as pb;

class NativeEngineError implements Exception {
  final Object internalError;
  v1alpha1.EngineError? pbError;

  String? get message => pbError?.message;
  int? get codeInt => pbError?.code;
  String? get codeString => codeInt != null ? getCodeString(codeInt!) : null;
  pb.Code? get code => codeInt != null ? pb.Code.valueOf(codeInt!) : null;

  NativeEngineError(this.internalError) {
    final e = internalError;
    if (e is v1alpha1.EngineError) {
      pbError = e;
    }
  }

  @override
  String toString() {
    final e = pbError;
    if (e == null) {
      return internalError.toString();
    }
    final codeString = getCodeString(e.code);
    return "NativeEngineError $codeString: ${e.toProto3Json()}";
  }
}

String getCodeString(int code) {
  return pb.Code.valueOf(code)?.name ?? "UNRECOGNIZED_CODE($code)";
}
