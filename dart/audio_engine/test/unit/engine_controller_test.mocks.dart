// Mocks generated by Mockito 5.4.4 from annotations
// in audio_engine/test/unit/engine_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i5;

import 'package:audio_engine/src/engine_message_channel.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:nam/nam.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [EngineMessageChannel].
///
/// See the documentation for Mockito's code generation for more information.
class MockEngineMessageChannel extends _i1.Mock
    implements _i2.EngineMessageChannel {
  @override
  _i3.Stream<_i4.Message> get receivedMessages => (super.noSuchMethod(
        Invocation.getter(#receivedMessages),
        returnValue: _i3.Stream<_i4.Message>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.Message>.empty(),
      ) as _i3.Stream<_i4.Message>);

  @override
  _i2.TransportType get transportType => (super.noSuchMethod(
        Invocation.getter(#transportType),
        returnValue: _i2.TransportType.ffi,
        returnValueForMissingStub: _i2.TransportType.ffi,
      ) as _i2.TransportType);

  @override
  void sendMessage(
    int? bodyType,
    _i5.Uint8List? messageContent,
    _i5.Uint8List? context,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #sendMessage,
          [
            bodyType,
            messageContent,
            context,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
