# Protobuf を利用した messaging の例

## 実行の仕方

Package の root で

```sh
dart ./example/protobuf_messaging/greeter_server.dart
```

別の terminal で

```sh
dart ./example/protobuf_messaging/greeter_client.dart
```

## Protobuf 周りのコード生成

Package の root で

```sh
protoc -I=./example/protobuf_messaging --dart_out=./example/protobuf_messaging/generated ./example/protobuf_messaging/helloworld.proto
```
