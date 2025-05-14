// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:ffi';

import 'package:uds_win/src/constants.dart';

base class SOCKADDR_UN extends Struct {
  @Uint16()
  external int sun_family;

  @Array(SOCKADDR_PATH_LENGTH)
  external Array<Uint8> sun_path;
}
