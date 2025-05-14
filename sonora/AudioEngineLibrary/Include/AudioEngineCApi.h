#pragma once
#include <stdint.h>

#if defined(_MSC_VER)

#if defined(NOVONOTES_DLL)
#define NOVONOTES_DLL_EXPORT __declspec(dllexport)
#else
#define NOVONOTES_DLL_EXPORT __declspec(dllimport)
#endif

#else  // defined(_MSC_VER)

#if defined(NOVONOTES_DLL)
#define NOVONOTES_DLL_EXPORT __attribute__((__visibility__("default")))
#else
#define NOVONOTES_DLL_EXPORT __attribute__((__visibility__("hidden")))
#endif

#endif  // defined(_MSC_VER)

/*
    この C API
   は、全ての関数が単一のスレッド/Isolateから呼びだされることを期待している。
*/

#ifdef __cplusplus
extern "C"
{
#endif

    /// Dynamically Linked Dart API の初期化処理
    /// その他の関数を呼び出す前に必ずこの関数を実行する必要がある。
    ///
    /// Dart_InitializeApiDL 関数はそのままでは DLL からエクスポートされないので
    /// 代わりにこの関数をエクスポートし、この関数の中で
    /// Dart_InitializeApiDL() 関数を呼び出すようにしている。
    NOVONOTES_DLL_EXPORT void initDartApi(void *data, int apiVersion,
                                          void (*onComplete)(intptr_t));

    /// MessageManager を初期化する
    /// この関数を呼び出す前に initDartApi 関数に渡したコールバックを使って
    /// initDartApi の処理完了を待つこと。
    NOVONOTES_DLL_EXPORT void initMessageManager(intptr_t hwnd,
                                                 void (*onComplete)(intptr_t));

    /// AudioEngine を初期化する
    /// この関数を呼び出す前に initMessageManager
    /// 関数に渡したコールバックを使って initMessageManager
    /// の処理完了を待つこと。
    NOVONOTES_DLL_EXPORT void initEngine(int64_t dartPortId,
                                         void (*onComplete)(intptr_t));

    /// AudioEngine をシャットダウンする
    NOVONOTES_DLL_EXPORT void shutdownEngine(void (*onComplete)(intptr_t));

    /// MessageManager をシャットダウンする
    /// この関数を呼び出す前に shutdownEngine 関数に渡したコールバックを使って
    /// shutdownEngine の処理完了を待つこと。
    NOVONOTES_DLL_EXPORT void shutdownMessageManager(
        void (*onComplete)(intptr_t));

    /// Dart API をシャットダウンする
    /// この関数を呼び出す前に shutdownMessageManager
    /// 関数に渡したコールバックを使って shutdownMessageManager
    /// の処理完了を待つこと。
    NOVONOTES_DLL_EXPORT void shutdownDartApi(void (*onComplete)(intptr_t));

    /// AudioEngine にメッセージを送り、処理を呼び出す
    /// この関数を呼び出す前に initEngine 関数に渡したコールバックを使って
    /// initEngine の処理完了を待つこと。
    NOVONOTES_DLL_EXPORT void sendMessageToEngine(unsigned char const *msg,
                                                  int len,
                                                  void (*onComplete)(intptr_t));

    /// JUCE のメッセージを手動で dispatch するための API
    ///
    /// 多くの場合このメソッドを用いなくても良いが、
    /// メッセージマネージャのメッセージループが回っていない場合にこのメソッドを呼び出すことで、
    /// その時 Queue に溜まっているメッセージの処理をリクエストできる。
    /// 例えば、Windows 上で package:flutter_test
    /// を用いたテストを行う場合に必要になる。
    NOVONOTES_DLL_EXPORT intptr_t dispatchNextJuceMessage();

    /// エンジンの現在の状態を取得する
    NOVONOTES_DLL_EXPORT intptr_t getState();

#ifdef __cplusplus
}
#endif
