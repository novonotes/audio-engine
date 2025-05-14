import 'dart:io';
import 'package:rxdart/rxdart.dart';

extension DatagramStream on RawDatagramSocket {
  Stream<Datagram> get datagramStream =>
      where((event) => event == RawSocketEvent.read)
          .map((RawSocketEvent event) => receive())
          .whereNotNull();
}
