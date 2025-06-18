

#pragma once
#include <juce_core/juce_core.h>

#include "Common/Ids.h"

namespace novonotes
{
class EngineKernel;

/*
    Debug Utility

    Test や Debug 用の Utility サービス。
    このサービスの仕様は変わりやすく、
    プロダクションコードから呼び出すべきではない。
 */
class DebugUtilityService
{
   public:
    DebugUtilityService(EngineKernel& kernel);

    void testTone();

    /*
        Tracktion Waveform のアプリケーションで作成した .tracktionedit
       拡張子のファイルをオーディオエンジンに読み込む。
    */
    void loadEditFromFileMadeByWaveform(const juce::File& editFile);

    /*
        保存ファイルは、人間が読める XML ファイル。また、以下の手順で、Tracktion
       Waveform のアプリケーションで開くことも可能。

        手順:
        1. 保存したファイルが .tracktionedit
       の拡張子でない場合、その拡張子に変更する。
        2. Waveform で適当なプロジェクトを新規作成する
        3. Project Item の一覧画面に .tracktionedit
       のファイルをドラッグアンドドロップする
        4. ドロップしたら一覧に表示されるので、クリックして開く
    */
    void saveState(const juce::File& dest);

    /// オーディオエンジンの現在の内部状態を人間が読める文字列でダンプします。
    std::string getDebugState();

    /// オーディオエンジンの内部実装で用いられている Engine
    /// のオブジェクトのポインタを取得。
    /// 内部実装をよく知っている人のためのデバッグ用メソッド。
    void* getInternalEngine();

    /// オーディオエンジンの内部実装で用いられている Edit
    /// のオブジェクトのポインタを取得。
    /// 内部実装をよく知っている人のためのデバッグ用メソッド。
    void* getInternalEdit();

   private:
    EngineKernel& _kernel;
};
}  // namespace novonotes
