// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

/// Checks if a file exists at the given path.
/// - On Windows, uses the GetFileAttributes API to handle cases where
///   UDS (Unix Domain Socket) files may not be recognized as regular files.
/// - On other platforms, falls back to File.existsSync().
bool existsSync(String path) {
  if (!Platform.isWindows) {
    return File(path).existsSync();
  }
  final pathPtr = path.toNativeUtf16();
  try {
    final attributes = GetFileAttributes(pathPtr);
    const INVALID_FILE_ATTRIBUTES =
        0XFFFFFFFF; // Constant for invalid file attributes
    return attributes != INVALID_FILE_ATTRIBUTES;
  } finally {
    calloc.free(pathPtr); // Free allocated memory
  }
}

/// Deletes a file at the specified path.
/// - On Windows, uses the DeleteFile API to handle cases where UDS files
///   cannot be removed using standard Dart APIs.
/// - On other platforms, falls back to File.deleteSync().
/// - If the file does not exist, it prints a warning.
/// - Throws an exception if the file deletion fails due to permissions or file locks.
void deleteSync(String path) {
  if (!Platform.isWindows) {
    return File(path).deleteSync();
  }
  if (!existsSync(path)) {
    throw PathNotFoundException(path, OSError());
  }

  final pathPtr = path.toNativeUtf16();
  try {
    final deleteResult = DeleteFile(pathPtr);
    if (deleteResult == 0) {
      throw Exception(
          "Failed to delete the file at $path. Check permissions or file lock.");
    }
  } finally {
    calloc.free(pathPtr);
  }
}
