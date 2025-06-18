# Sonora App Bridge Plugin

このパッケージは、Sonora Audio Engine の機能を持った DAW プラグインの実装。
プロセス間通信に対応しており、プラグインホストとは別のアプリケーションから操作することができる。

## 設定

settings.json や settings.dev.json でプラグインの挙動を変更できます。
#ifdef DEBUG の時に settings.dev.json が使われます。（SettingsFile.h 参照）
開発には、以下のような内容の settings.dev.json を作成してください。
ファイルの配置場所は、[SettingsFile.h](./Source/Settings/SettingsFile.h) の `getSettingsFile` のコメントを参照。

```json
{
  "command": "/Applications/YourApp/Contents/MacOS/YourApp",
  "cwd": "/Users/YourName",
  "args": ["--app-bridge-mode", "--uds-path", "$SOCK_PATH"]
}
```

cwd はオプショナルです。
args 内の以下の文字列はプレースホルダとして扱われ、実行時に置き換えられます。

- `$SOCK_PATH`: プラグインと、アプリケーションの間の通信に使用される Unix Domain Socket のパス。
