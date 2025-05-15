# Debug 方法

以下のように幾つかのデバッグ方法があります。

- AudioEngineCore
- AudioEngineLibrary (IDEのデバッグ実行機能)
- AudioEngineLibrary (起動後にデバッガをアタッチする方法)
- AudioEngineService (初期化後にデバッガーをアタッチ)
- AudioEngineService (Scenario の Debug モード)

## AudioEngineCore

ExamplePlugin を使ってデバッグ可能です。

Scenario.h にシナリオを追加して、Standalone アプリをビルド・実行します。
GUI 上のボタンでシナリオを実行可能です。

## AudioEngineLibrary (IDEのデバッグ実行機能)

### 1. Flutter アプリケーションのビルド

以下の手順を実行し、このプロジェクトで生成する DLL を呼び出す側のアプリケーションをビルドする。

```sh
cd ../dart/audio_engine/example
flutter pub get
# 以下は debug_state_scenario を用いる場合の例
flutter build macos ./lib/scenario/v1alpha0/debug_state_scenario.dart --debug
cd -
```

以下のパスに成果物がビルドされる。

- macOS: `$DuoRoot/Packages/AudioEngine/dart/audio_engine/example/build/macos/Build/Products/Debug/audio_engine_example.app`
- Windows: `$DuoRoot\Packages\AudioEngine\dart\audio_engine\example\build\windows\x64\runner\Debug\audio_engine_example.exe`

### 2. IDE の設定

#### Xcode の場合

- Xcode で AudioEngineLibrary ターゲットのスキーマ設定ページを開き、デバッグする実行ファイルの箇所を 上記の成果物への path に設定する。
- 同じ、スキーマ設定ページの Options タブの Working Directory の項目を `$DuoRoot/Packages/AudioEngine/dart/audio_engine/example` に設定する。

Xcode 左上の Run ボタンで実行する。

#### Visual Studio の場合

- Solution Explorer で AudioEngineLibrary ターゲットを右クリックし、コンテクストメニューからプロパティページを開く。Configuration Properties → Debugging → Command の箇所を 上記の成果物への path に設定する。
- 同じページの Working Directory の箇所を `$DuoRoot/Packages/AudioEngine/dart/audio_engine/example` に設定する。

Solution Explorer で AudioEngineLibrary ターゲットを右クリックし、コンテクストメニューから Debug → Start New Instance を選ぶ。

## AudioEngineLibrary（起動後にデバッガをアタッチする方法）

### 1. デバッグ機能の有効化

AudioEngineCApi.cpp の initDartApi() 関数の冒頭の `#if 0` マクロを `#if 1` に書き換えて、デバッガのアタッチを待つ無限ループを有効にする。

```
#if 0  // ここを 1に変更することでデバッグ機能が有効になる。

        // デバッグ用機能。これを1にセットすると無限ループが発生して、
        // デバッガをアタッチするタイミングが作れるようになる
        // デバッガでアタッチしたあとで wait 変数の値を false
        // にセットするとループを抜けて処理を続行できる。
        static int wait = true;
        for(;;)
        {
            if(wait == false)
            {
                break;
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
#endif
```

### 2. flutter のアプリケーション実行

以下は debug_state_scenario.dart を用いる場合の例。

```
cd ../dart/audio_engine/example
flutter run ./lib/scenario/v1alpha0/debug_state_scenario.dart
cd -
```

### 3. デバッガの操作

1. 処理が無限ループに入ったタイミングで Visual Studio 側で メニュー の デバッグ → プロセスにアタッチ を実行し、 audio_engine_example.exe を探してアタッチする。
2. 処理を確認したい関数の箇所にブレークポイントを仕掛ける。
3. さらに無限ループの箇所にブレークポイントを仕掛ける。処理が停止するのでイミディエイトウィンドウで wait 変数を `0` に書き換える。
4. この状態でプロセスの処理を続行する。
5. `2.` のステップでブレークポイントを仕掛けた位置まで処理が進むとデバッガによって目的の位置で処理が停止するはず。

## AudioEngineService (初期化後にデバッガーをアタッチ)

### 1. テストやプログラムの実行

dart のテストやプログラムをデバッグ実行する。このとき AudioEngineService の起動直後の行にブレークポイントを追加する等の方法で、デバッガーのアタッチを待つようにする。

### 2. 起動した AudioEngineService のプロセスにデバッガーをアタッチ

IDE 等で AudioEngineService のプロセスにデバッガをアタッチする。

### 3. テストやプログラムを再開

`1.` のステップで止めたテストやプログラムを再開する。

## AudioEngineService (Scenario の Debug モード)

### 1. シナリオの選択

`dart/audio_engine/example/test/scenario_test` の中から、Debug に用いる Dart 側の シナリオを選ぶ。

### 2. Test の書き換え

dart のテストコード内の `engineDebugMode` を true に書き換え。

```dart
  group("Out-process Engine Scenario: ", () {
    const engineDebugMode = false;  // ここを true に変更
    late AudioEngineController engineController;
    late StartAndStopScenario scenario;
```

これにより以下の点が変更になる。

- test の timeout が十分デバッグ可能な時間まで伸びる。
- dart 側で subprocess を起動しなくなる。
- コンソールへの log 出力が有効になる。

Dart 側のテストは、最初にソケットサーバーに接続したオーディオエンジンを用いてシナリオを実行するようになる。ソケットサーバーのアドレスはコンソールに出力される。

### 3. テストの実行

```sh
cd ../dart/audio_engine/example
flutter pub get
flutter test ./test/v1alpha0/debug_state_test.dart --debug
cd -
```

UDS のサーバーを起動し、最初のエンジンのクライアントを待つ状態で止まるはず。

### 4. AudioEngineService の実行

IDE 等で AudioEngineService のターゲットをデバッグ実行する。
