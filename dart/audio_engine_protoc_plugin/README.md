# audio_engine_protoc_plugin

使い方の例

```sh
protoc --engine_out=out --plugin=./bin/protoc-gen-engine example.proto
```

dart コードをコンパイルする必要はないが、事前に `yarn prepare:dart` しないといけない。
