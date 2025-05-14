# Contributing

コードに手を加えようとするコントリビューターやメンテナー向けのドキュメント。

## Code Generation

protobuf のスキーマ定義に基づく、コード生成について。
Packages/APIs/novonotes/audio_engine のディレクトリにある、proto ファイルから、
./lib/src/generated 以下の C++ ソースコードやヘッダーを生成します。

まず、以下のインストールが必要です。

- [Protoc](http://protobuf.dev/getting-started/cpptutorial/#compiling-your-protocol-buffers)
- [Protoc Plugin](https://pub.dev/packages/protoc_plugin)

コード生成の手順は以下です。

```sh
# dart/audio_engine ディレクトリで
bash protoc.sh
```
