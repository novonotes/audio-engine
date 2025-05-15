# Contributing

コードに手を加えようとするコントリビューターやメンテナー向けのドキュメント。

## Formatter

clang-format v19 を使用してください。

macOS での install 方法の例:

```sh
brew install clang-format@19
```

## Code Generation

protobuf のスキーマ定義に基づく、コード生成について。
Packages/APIs/novonotes/audio_engine のディレクトリにある、proto ファイルから、
./Modules/AudioEngineProto 以下の C++ ソースコードやヘッダーを生成します。

まず、以下のインストールが必要です。

- [Protoc](http://protobuf.dev/getting-started/cpptutorial/#compiling-your-protocol-buffers)

コード生成の手順は以下です。

```sh
# cpp ディレクトリで
bash protoc.sh
```

## External Library Dependencies

### Tracktion Engine

Tracktion Engine のヘッダーをインクルードしていいのは、`Modules/AudioEngineCore/Impl` の中だけ。それ以外の場所ではコンパイルエラーになるはず。
将来、Engine の実装を TracktionEngine を用いない独自実装に書き換える可能性がある。その際に、`Impl` の中だけを書き換えればいいようにしておきたい。

### Protobuf

`AudioEngineCore` では、Protobuf 関連のヘッダー（`audio_engine.pb.h` など）をインクルードしてはいけない。インクルードしようとするとコンパイルエラーになるはず。
将来、パフォーマンスの観点等で、アプリケーションとのコミュニケーションに Protobuf 以外の方法を追加する可能性がある。その際に、`AudioEngineCore` 以下のコードは再利用できるようにしておきたい。

## Documents

コードに手を加えようとするコントリビューターやメンテナーは、以下のドキュメントも必ず読んでください。

- [debugging.md](./debugging.md)
- [class-diagram.md](./class-diagram.md)
- [audio-engine-api.md](../doc/audio-engine-api.md)
- [nam.md](../doc/nam.md)
- [sequences.md](../doc/sequences.md)
