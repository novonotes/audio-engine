//
//  Generated code. Do not modify.
//  source: google/rpc/code.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  The canonical error codes for gRPC APIs.
///
///
///  Sometimes multiple error codes may apply.  Services should return
///  the most specific error code that applies.  For example, prefer
///  `OUT_OF_RANGE` over `FAILED_PRECONDITION` if both codes apply.
///  Similarly prefer `NOT_FOUND` or `ALREADY_EXISTS` over `FAILED_PRECONDITION`.
class Code extends $pb.ProtobufEnum {
  ///  Not an error; returned on success.
  ///
  ///  HTTP Mapping: 200 OK
  static const Code OK = Code._(0, _omitEnumNames ? '' : 'OK');

  ///  The operation was cancelled, typically by the caller.
  ///
  ///  HTTP Mapping: 499 Client Closed Request
  static const Code CANCELLED = Code._(1, _omitEnumNames ? '' : 'CANCELLED');

  ///  Unknown error.  For example, this error may be returned when
  ///  a `Status` value received from another address space belongs to
  ///  an error space that is not known in this address space.  Also
  ///  errors raised by APIs that do not return enough error information
  ///  may be converted to this error.
  ///
  ///  HTTP Mapping: 500 Internal Server Error
  static const Code UNKNOWN = Code._(2, _omitEnumNames ? '' : 'UNKNOWN');

  ///  The client specified an invalid argument.  Note that this differs
  ///  from `FAILED_PRECONDITION`.  `INVALID_ARGUMENT` indicates arguments
  ///  that are problematic regardless of the state of the system
  ///  (e.g., a malformed file name).
  ///
  ///  HTTP Mapping: 400 Bad Request
  static const Code INVALID_ARGUMENT =
      Code._(3, _omitEnumNames ? '' : 'INVALID_ARGUMENT');

  ///  The deadline expired before the operation could complete. For operations
  ///  that change the state of the system, this error may be returned
  ///  even if the operation has completed successfully.  For example, a
  ///  successful response from a server could have been delayed long
  ///  enough for the deadline to expire.
  ///
  ///  HTTP Mapping: 504 Gateway Timeout
  static const Code DEADLINE_EXCEEDED =
      Code._(4, _omitEnumNames ? '' : 'DEADLINE_EXCEEDED');

  ///  Some requested entity (e.g., file or directory) was not found.
  ///
  ///  Note to server developers: if a request is denied for an entire class
  ///  of users, such as gradual feature rollout or undocumented allowlist,
  ///  `NOT_FOUND` may be used. If a request is denied for some users within
  ///  a class of users, such as user-based access control, `PERMISSION_DENIED`
  ///  must be used.
  ///
  ///  HTTP Mapping: 404 Not Found
  static const Code NOT_FOUND = Code._(5, _omitEnumNames ? '' : 'NOT_FOUND');

  ///  The entity that a client attempted to create (e.g., file or directory)
  ///  already exists.
  ///
  ///  HTTP Mapping: 409 Conflict
  static const Code ALREADY_EXISTS =
      Code._(6, _omitEnumNames ? '' : 'ALREADY_EXISTS');

  ///  The caller does not have permission to execute the specified
  ///  operation. `PERMISSION_DENIED` must not be used for rejections
  ///  caused by exhausting some resource (use `RESOURCE_EXHAUSTED`
  ///  instead for those errors). `PERMISSION_DENIED` must not be
  ///  used if the caller can not be identified (use `UNAUTHENTICATED`
  ///  instead for those errors). This error code does not imply the
  ///  request is valid or the requested entity exists or satisfies
  ///  other pre-conditions.
  ///
  ///  HTTP Mapping: 403 Forbidden
  static const Code PERMISSION_DENIED =
      Code._(7, _omitEnumNames ? '' : 'PERMISSION_DENIED');

  ///  The request does not have valid authentication credentials for the
  ///  operation.
  ///
  ///  HTTP Mapping: 401 Unauthorized
  static const Code UNAUTHENTICATED =
      Code._(16, _omitEnumNames ? '' : 'UNAUTHENTICATED');

  ///  Some resource has been exhausted, perhaps a per-user quota, or
  ///  perhaps the entire file system is out of space.
  ///
  ///  HTTP Mapping: 429 Too Many Requests
  static const Code RESOURCE_EXHAUSTED =
      Code._(8, _omitEnumNames ? '' : 'RESOURCE_EXHAUSTED');

  ///  The operation was rejected because the system is not in a state
  ///  required for the operation's execution.  For example, the directory
  ///  to be deleted is non-empty, an rmdir operation is applied to
  ///  a non-directory, etc.
  ///
  ///  Service implementors can use the following guidelines to decide
  ///  between `FAILED_PRECONDITION`, `ABORTED`, and `UNAVAILABLE`:
  ///   (a) Use `UNAVAILABLE` if the client can retry just the failing call.
  ///   (b) Use `ABORTED` if the client should retry at a higher level. For
  ///       example, when a client-specified test-and-set fails, indicating the
  ///       client should restart a read-modify-write sequence.
  ///   (c) Use `FAILED_PRECONDITION` if the client should not retry until
  ///       the system state has been explicitly fixed. For example, if an "rmdir"
  ///       fails because the directory is non-empty, `FAILED_PRECONDITION`
  ///       should be returned since the client should not retry unless
  ///       the files are deleted from the directory.
  ///
  ///  HTTP Mapping: 400 Bad Request
  static const Code FAILED_PRECONDITION =
      Code._(9, _omitEnumNames ? '' : 'FAILED_PRECONDITION');

  ///  The operation was aborted, typically due to a concurrency issue such as
  ///  a sequencer check failure or transaction abort.
  ///
  ///  See the guidelines above for deciding between `FAILED_PRECONDITION`,
  ///  `ABORTED`, and `UNAVAILABLE`.
  ///
  ///  HTTP Mapping: 409 Conflict
  static const Code ABORTED = Code._(10, _omitEnumNames ? '' : 'ABORTED');

  ///  The operation was attempted past the valid range.  E.g., seeking or
  ///  reading past end-of-file.
  ///
  ///  Unlike `INVALID_ARGUMENT`, this error indicates a problem that may
  ///  be fixed if the system state changes. For example, a 32-bit file
  ///  system will generate `INVALID_ARGUMENT` if asked to read at an
  ///  offset that is not in the range [0,2^32-1], but it will generate
  ///  `OUT_OF_RANGE` if asked to read from an offset past the current
  ///  file size.
  ///
  ///  There is a fair bit of overlap between `FAILED_PRECONDITION` and
  ///  `OUT_OF_RANGE`.  We recommend using `OUT_OF_RANGE` (the more specific
  ///  error) when it applies so that callers who are iterating through
  ///  a space can easily look for an `OUT_OF_RANGE` error to detect when
  ///  they are done.
  ///
  ///  HTTP Mapping: 400 Bad Request
  static const Code OUT_OF_RANGE =
      Code._(11, _omitEnumNames ? '' : 'OUT_OF_RANGE');

  ///  The operation is not implemented or is not supported/enabled in this
  ///  service.
  ///
  ///  HTTP Mapping: 501 Not Implemented
  static const Code UNIMPLEMENTED =
      Code._(12, _omitEnumNames ? '' : 'UNIMPLEMENTED');

  ///  Internal errors.  This means that some invariants expected by the
  ///  underlying system have been broken.  This error code is reserved
  ///  for serious errors.
  ///
  ///  HTTP Mapping: 500 Internal Server Error
  static const Code INTERNAL = Code._(13, _omitEnumNames ? '' : 'INTERNAL');

  ///  The service is currently unavailable.  This is most likely a
  ///  transient condition, which can be corrected by retrying with
  ///  a backoff. Note that it is not always safe to retry
  ///  non-idempotent operations.
  ///
  ///  See the guidelines above for deciding between `FAILED_PRECONDITION`,
  ///  `ABORTED`, and `UNAVAILABLE`.
  ///
  ///  HTTP Mapping: 503 Service Unavailable
  static const Code UNAVAILABLE =
      Code._(14, _omitEnumNames ? '' : 'UNAVAILABLE');

  ///  Unrecoverable data loss or corruption.
  ///
  ///  HTTP Mapping: 500 Internal Server Error
  static const Code DATA_LOSS = Code._(15, _omitEnumNames ? '' : 'DATA_LOSS');

  static const $core.List<Code> values = <Code>[
    OK,
    CANCELLED,
    UNKNOWN,
    INVALID_ARGUMENT,
    DEADLINE_EXCEEDED,
    NOT_FOUND,
    ALREADY_EXISTS,
    PERMISSION_DENIED,
    UNAUTHENTICATED,
    RESOURCE_EXHAUSTED,
    FAILED_PRECONDITION,
    ABORTED,
    OUT_OF_RANGE,
    UNIMPLEMENTED,
    INTERNAL,
    UNAVAILABLE,
    DATA_LOSS,
  ];

  static final $core.Map<$core.int, Code> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Code? valueOf($core.int value) => _byValue[value];

  const Code._(super.v, super.n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
