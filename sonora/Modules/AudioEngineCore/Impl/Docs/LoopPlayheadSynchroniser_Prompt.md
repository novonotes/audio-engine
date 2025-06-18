DAW プラグインを作っています。tracktion engine というライブラリを使用して、プラグインの内部処理を実装しています。

これから、tracktion_ExternalPlayheadSynchroniser を参考に、以下の機能を追加した、LoopPlayheadSynchroniser クラスを実装します。

- tracktion engine が EngineInPlugin モードで利用しているときに、ホスト（DAW）の再生位置と同期しつつEdit のループ設定も有効にするSynchroniser。
- 具体的な挙動は下記の表参照。
- 利用方法は EngineInPluginDemo.h を参照してください。ExternalPlayheadSynchroniser を新たな Synchroniser に置き換えたいです。
- Offset はメンバ変数に保持し、外部から設定できるようにしてください。メインスレッドから設定します。
- Loop の Start/end の設定もメンバ変数に保持し、外部から設定できるようにしてください。メインスレッドから設定します。synchronise の引数から取れるループ設定はホストのループ設定なので、Edit のループ設定とは異なります。無視してください。
- リアルタイムスレッドから呼び出すので、メモリアロケーションをさけるなどの、リアルタイムプログラミングで一般的なルールを守ってください。
- コメントは日本語で。実装者よりも、クラス利用者にとってわかりやすいコメントを心がけて。関数のコメントは、どのスレッドから呼び出しを想定しているかを書いて。
- Private メンバ変数名はアンダースコアのプレフィックスをつけて。

| Host の再生位置（ppq） | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   |
| ---------------------- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

| Edit の再生位置
(ループ設定: Start=0, End=2, Offset=0) | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 |
| Edit の再生位置
(ループ設定: Start=1, End=3, Offset=0) | 0 | 1 | 2 | 1 | 2 | 1 | 2 | 1 | 2 |
| Edit の再生位置
(ループ設定: Start=0, End=2, Offset=1) | 休み | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 |
| Edit の再生位置
(ループ設定: Start=1, End=3, Offset=1) | 休み | 0 | 1 | 2 | 1 | 2 | 1 | 2 | 1 |

@tracktion_ExternalPlayheadSynchroniser.h @tracktion_ExternalPlayheadSynchroniser.cpp @EngineInPluginDemo.h

まず最初に、EngineInPluginDemo.h を参照して、どの関数が必要かを洗い出し、クラスインターフェースのデザインをしてください。
次にヘッダー .h を記述してください。
最後に .cpp を実装してください。
