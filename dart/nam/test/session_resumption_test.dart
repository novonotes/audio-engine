import 'dart:async';
import 'dart:io';

import 'package:nam/src/client.dart';
import 'package:nam/src/logger.dart';
import 'package:nam/src/server.dart';
import 'package:nam/src/session_manager.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:uds_win/fs.dart' as fs;
import 'package:uds_win/uds_win.dart' as uds_win;

void main() {
  group(
    'Nam Session Resumption',
    () {
      Logger.enabled = true;
      late ServerSocket serverSocket;
      late File udsFile;

      setUp(() async {
        final sockPath = path.join(
          Directory.systemTemp.path,
          "novonotes",
          "session_resumption.sock",
        );
        udsFile = File(sockPath);
        await udsFile.parent.create(recursive: true);

        if (fs.existsSync(udsFile.path)) {
          fs.deleteSync(udsFile.path);
        }

        const port = 4567;
        final host = InternetAddress(
          udsFile.path,
          type: InternetAddressType.unix,
        );

        serverSocket = await uds_win.ServerSocket.bind(host, port);
        print("Server socket bound to: ${serverSocket.address}");
      });

      tearDown(() async {
        serverSocket.close();
      });

      // - client 1 を作成。
      // - client 1 を close 。
      // - client 2 を 作成。client 1 のセッションを引き継ぐようにリクエスト。
      // - ハンドシェイク後も client 2 と client 1 が同じセッション ID をもつはず。
      test(
        '再接続時に前回のセッションを再開できるはず。',
        () async {
          NamSocketServer(
            serverSocket,
            sessionManager: NamSessionManager(
              reconnectionTimeout: Duration(seconds: 10),
            ),
          );

          expect(
            fs.existsSync(udsFile.path),
            isTrue,
            reason: "UDS file should be created.",
          );
          print("UDS file exists: ${udsFile.path}");

          final client1 = await NamSocketClient.connect(
            InternetAddress(
              udsFile.path,
              type: InternetAddressType.unix,
            ),
            4567,
          );

          expect(client1.sessionId, 0);

          await client1.ready.timeout(
            Duration(seconds: 3),
            onTimeout: () =>
                throw TimeoutException("Client 1: Handshake failed."),
          );

          expect(client1.sessionId, isNot(0));

          await client1.close();

          final client2 = await NamSocketClient.connect(
            InternetAddress(
              udsFile.path,
              type: InternetAddressType.unix,
            ),
            4567,
            sessionId: client1.sessionId, // サーバー側にセッションの継続をリクエスト。
          );

          await client2.ready.timeout(
            Duration(seconds: 3),
            onTimeout: () =>
                throw TimeoutException("Client 2: Handshake failed."),
          );

          expect(client2.sessionId, equals(client1.sessionId));
        },
      );

      // - client 1 を作成。
      // - client 1 を close 。
      // - セッションがタイムアウトで無効になるまで待つ。
      // - client 2 を 作成。client 1 のセッションを引き継ぐようにリクエスト。
      // - サーバー側でセッションの引き継ぎは拒否されるはず。
      // - ハンドシェイク後、 client 2 と client 1 は異なるセッション ID を持つはず。
      test(
        '再接続時にセッションが期限切れの場合は、セッション再開できないはず。',
        () async {
          NamSocketServer(
            serverSocket,
            sessionManager: NamSessionManager(
              reconnectionTimeout: Duration(milliseconds: 300),
            ),
          );

          expect(
            fs.existsSync(udsFile.path),
            isTrue,
            reason: "UDS file should be created.",
          );
          print("UDS file exists: ${udsFile.path}");

          final client1 = await NamSocketClient.connect(
            InternetAddress(
              udsFile.path,
              type: InternetAddressType.unix,
            ),
            4567,
          );

          expect(client1.sessionId, 0);

          await client1.ready.timeout(
            Duration(seconds: 3),
            onTimeout: () =>
                throw TimeoutException("Client 1: Handshake failed."),
          );

          expect(client1.sessionId, isNot(0));

          await client1.close();

          // [NamSessionManager] の初期化時に、timeout を 300ms に指定したので、400 ms 待てば必ずセッションは無効になっているはず。
          await Future.delayed(const Duration(milliseconds: 400));

          final client2 = await NamSocketClient.connect(
            InternetAddress(
              udsFile.path,
              type: InternetAddressType.unix,
            ),
            4567,
            sessionId: client1.sessionId, // サーバー側にセッションの継続をリクエスト。
          );

          await client2.ready.timeout(
            Duration(seconds: 3),
            onTimeout: () =>
                throw TimeoutException("Client 2: Handshake failed."),
          );

          expect(client2.sessionId, isNot(client1.sessionId));
          expect(client2.sessionId, isNot(0));
        },
      );
    },
  );
}
