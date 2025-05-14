/*
  プロトコルの仕様については nam.md を参照
*/

import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'constants.dart';

typedef BodyType = int;
typedef Version = int;
typedef SessionId = int;

const Version protocolVersion = 0;

int getUint16FromUint8List(Uint8List buf, {int byteOffset = 0}) {
  return ByteData.view(buf.buffer).getUint16(byteOffset);
}

int getUint32FromUint8List(Uint8List buf, {int byteOffset = 0}) {
  return ByteData.view(buf.buffer).getUint32(byteOffset);
}

Uint8List uint16ToUint8List(int num) {
  // int 型で受け取るが uint16 の最大値を上回ってはいけない
  assert(0 <= num && num <= uint16Max);
  final data = ByteData(2);
  data.setUint16(0, num);
  return data.buffer.asUint8List();
}

Uint8List uint32ToUint8List(int num) {
  // int 型で受け取るが uint32 の最大値を上回ってはいけない
  assert(0 <= num && num <= uint32Max);
  final data = ByteData(4);
  data.setUint32(0, num);
  return data.buffer.asUint8List();
}

class MessageBuilder {
  /// Uint8List のバッファを受け取り Message のオブジェクトを Build する
  /// input に複数のメッセージ分のデータが入っていたり、一つのメッセージの途中までのデータしか入っていない場合をうまくハンドリングする
  ///
  /// 1. buildQueue に入力されたデータを追加する
  /// 2. メッセージを作るのに十分なデータサイズがあれば build する
  List<Message> build(Uint8List input) {
    _buildQueue.addAll(input);
    List<Message> ret = [];
    while (_enoughDataInQueue) {
      final buf = Uint8List(_firstMessageSize);
      buf.setAll(0, _buildQueue.getRange(0, buf.length));
      ret.add(Message(buf));
      _buildQueue.removeRange(0, buf.length);
    }
    return ret;
  }

  bool get _enoughDataInQueue {
    if (_buildQueue.length < 13) {
      return false;
    }

    // buildQueue のバッファが、最初のメッセージの一部分しか含んでいない場合は false を返す
    if (_buildQueue.length < _firstMessageSize) {
      return false;
    }
    return true;
  }

  /// buildQueue 変数に含まれる最初のメッセージのサイズ
  int get _firstMessageSize {
    assert(_buildQueue.length >= 13);
    Uint8List contextSizeBuffer = Uint8List(4);
    Uint8List bodySizeBuffer = Uint8List(4);
    contextSizeBuffer.setRange(0, 4, _buildQueue, 5);
    bodySizeBuffer.setRange(0, 4, _buildQueue, 9);

    int contextSize = getUint32FromUint8List(contextSizeBuffer);
    int bodySize = getUint32FromUint8List(bodySizeBuffer);
    return 13 + contextSize + bodySize;
  }

  final List<int> _buildQueue = [];
}

/// nam.md を参照
@immutable
class Message {
  final Uint8List buffer;

  Message(this.buffer) {
    assert(buffer.length >= 13);
    assert(messageSize == buffer.length);
    assert(bodySize == body.length);
  }

  static Message from({
    required SessionId sessionId,
    required BodyType bodyType,
    required Uint8List context,
    required Uint8List body,
  }) {
    final contextSize = context.length;
    final bodySize = body.length;
    assert(0 <= sessionId && sessionId <= uint16Max);
    assert(0 <= bodyType && bodyType <= uint16Max);
    if (contextSize > uint32Max) {
      throw Exception("The message context size exceeds the limit.");
    }
    if (bodySize > uint32Max) {
      throw Exception("The message body size exceeds the limit.");
    }
    final buf = Uint8List(bodySize + contextSize + 13);
    buf[0] = protocolVersion;
    buf.setRange(1, 3, uint16ToUint8List(sessionId));
    buf.setRange(3, 5, uint16ToUint8List(bodyType));
    buf.setRange(5, 9, uint32ToUint8List(contextSize));
    buf.setRange(9, 13, uint32ToUint8List(bodySize));
    buf.setRange(13, 13 + contextSize, context);
    buf.setRange(13 + contextSize, buf.length, body);
    final msg = Message(buf);
    assert(msg.buffer.length >= 13);
    assert(msg.bodySize == body.length);
    assert(msg.messageSize == buf.length);
    return msg;
  }

  Version get version => buffer[0];
  SessionId get sessionId => getUint16FromUint8List(buffer, byteOffset: 1);
  BodyType get bodyType => getUint16FromUint8List(buffer, byteOffset: 3);
  int get contextSize => getUint32FromUint8List(buffer, byteOffset: 5);
  int get bodySize => getUint32FromUint8List(buffer, byteOffset: 9);

  int get headerSize => contextSize + 13;
  int get messageSize => bodySize + headerSize;

  Uint8List get context => Uint8List.fromList(
        buffer.getRange(13, headerSize).toList(),
      );
  Uint8List get body => Uint8List.fromList(
        buffer.getRange(headerSize, messageSize).toList(),
      );
}
