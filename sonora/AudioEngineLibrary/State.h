
#pragma once

#include <atomic>

namespace State
{
constexpr int UNINITIALIZED =
    0;  // 何も初期化されていない。初期状態または、Dart
        // API シャットダウンの完了後の状態。
constexpr int DART_API_INITIALIZING = 100;         // Dart API 初期化中
constexpr int DART_API_INITIALIZED = 200;          // Dart API 初期化完了
constexpr int MESSAGE_MANAGER_INITIALIZING = 300;  // MessageManager 初期化中
constexpr int MESSAGE_MANAGER_INITIALIZED = 400;   // MessageManager 初期化完了
constexpr int ENGINE_INITIALIZING = 500;           // AudioEngine 初期化中
constexpr int ENGINE_INITIALIZED = 600;            // AudioEngine 初期化完了
constexpr int ENGINE_SHUTTING_DOWN = 700;  // AudioEngine シャットダウン中
constexpr int ENGINE_SHUT_DOWN = 800;      // AudioEngine シャットダウン完了
constexpr int MESSAGE_MANAGER_SHUTTING_DOWN =
    900;  // MessageManager シャットダウン中
constexpr int MESSAGE_MANAGER_SHUT_DOWN =
    1000;  // MessageManager シャットダウン完了
constexpr int DART_API_SHUTTING_DOWN = 1100;  // Dart API シャットダウン中
}  // namespace State

extern std::atomic<int> g_apiState;
