# audio_engine

Flutter 向けのオーディオエンジン。
Flutter に依存するので、pure な dart のプロジェクトでは使用できません。

## Features

- Sequencing audio and MIDI.
- Building audio device graph.
- Hosting audio plugins (e.g. VST3 and AU).

## Supported Platforms

The following platforms are supported:

- **macOS**
- **Windows**
- **Linux**
- **iOS**: In-process audio engine のみ。

Unsupported platforms:

- **Andoroid**: Not supported yet. Pull requests are welcome.
- **Web**: Out-of-scope of this project. Please find other solutions.

## Getting Started

### Install

```sh
flutter pub add audio_engine
```

### Project Configuration

audio_engine を用いるには、Platform ごとに以下の設定が必要です。

#### iOS

AudioEngine のフレームワーク(iOS のネイティブのライブラリ)をアプリにリンクするため、audio_engine_flutter_libs のパッケージを依存に追加します。

```sh
flutter pub add audio_engine_flutter_libs
```

iOS でマイクを使うには、Info.plist に適切な使用目的を説明する必要があります。
`YourApp/ios/Runner/Info.plist` の `<dict>` の中に以下のような行を追加してください。

```
<key>NSMicrophoneUsageDescription</key>
<string>This app requires access to the microphone for recording audio.</string>
```

#### その他のプラットフォーム

特別な設定は必要ありません。

## Contributing

コードに手を加えようとするコントリビューターやメンテナーは、[contributing.md](./contributing.md) を必ず読んでください。
