# audio-engine
A monorepo providing an audio engine for production applications—DAWs, audio editors, and DAW plugins—with integration code for app frameworks.

汎用的なオーディオエンジンの実装。NovoNotes の特定の製品に限定せず、幅広いアプリケーションのコンポーネントとして利用できる設計を目指しています。

以下のように様々な使用方法が可能です。

- **Audio Engine Modules**: JUCE プラグインやその他の C++ アプリケーションに統合するのに適しています。使用例は [ExamplePlugin](./sonora/ExamplePlugin) で確認してください。
- **Audio Engine Service**: 独立したプログラムです。他のアプリケーションからサブプロセスとして起動し、プロセス間通信によって制御できます。
- **Audio Engine Library**: 動的にロードするライブラリです。他言語からの利用までを想定した C の API を公開しています。現在 Dart からの使用のみを想定した実装になっているが、将来的には拡張可能なはずです。

