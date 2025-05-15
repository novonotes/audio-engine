# Sonora App Bridge Plugin

このパッケージは、Sonora Audio Engine の機能を持った DAW プラグインの実装。
プロセス間通信に対応しており、プラグインホストとは別のアプリケーションから操作することができる。

## 設定

settings.json や settings.dev.json でプラグインの挙動を変更できます。
開発には、以下のような内容の settings.dev.json を作成してください。
ファイルの配置場所は、[SettingsFile.h](./Source/Settings/SettingsFile.h) の `getSettingsFile` のコメントを参照。

```json
{
  "applicationPath": "/Users/YourName/Application/beatgen.app",
  "cwd": "/Users/YourName/Application"
}
```
