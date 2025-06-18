

#pragma once
#include <functional>

namespace MessageManagerPlatformIntegration
{
#if JUCE_WINDOWS
// メッセージマネージャーの初期化
void initialize(intptr_t hwnd, void (*onComplete)(intptr_t));
#else
// メッセージマネージャーの初期化
void initialize(void (*onComplete)(intptr_t));
#endif

// メッセージマネージャーの終了処理
void shutdown(void (*onComplete)(intptr_t));
}  // namespace MessageManagerPlatformIntegration
