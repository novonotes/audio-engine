import 'dart:ffi';

final DynamicLibrary _winsockLib = DynamicLibrary.open('Ws2_32.dll');

final int Function() wsaGetLastError = _winsockLib
    .lookupFunction<Int32 Function(), int Function()>('WSAGetLastError');
