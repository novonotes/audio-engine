#pragma once
#include <juce_core/juce_core.h>

/// プラットフォームごとの設定ディレクトリを取得する関数
/// 各プラットフォームでのディレクトリ例:
/// - Windows: C:\Users\<ユーザー名>\AppData\Roaming\Sonora App Bridge
/// - macOS:   /Users/<ユーザー名>/Library/Application Support/Sonora App Bridge
/// - Linux:   /home/<ユーザー名>/.config/Sonora App Bridge
static juce::File getConfigDir()
{
    // ユーザー専用のアプリケーションデータディレクトリを取得
    juce::File appDataDir = juce::File::getSpecialLocation(
        juce::File::userApplicationDataDirectory);

// 各プラットフォームごとの設定ディレクトリ
#if JUCE_WINDOWS
    // Windows: %APPDATA%\Sonora App Bridge
    return appDataDir.getChildFile("Sonora App Bridge");
#elif JUCE_MAC
    // macOS: ~/Library/Application Support/Sonora App Bridge
    return appDataDir.getChildFile("Application Support")
        .getChildFile("Sonora App Bridge");
#elif JUCE_LINUX
    // Linux: ~/.config/Sonora App Bridge
    return appDataDir.getChildFile("Sonora App Bridge");
#else
#error "Unsupported platform"
#endif
}

/// 設定ファイルへのフルパスを取得する関数
/// 各プラットフォームでの設定ファイル例:
/// - Windows (リリース):
/// C:\Users\<ユーザー名>\AppData\Roaming\Sonora App Bridge\settings.json
/// - Windows (デバッグ):
/// C:\Users\<ユーザー名>\AppData\Roaming\Sonora App Bridge\settings.dev.json
/// - macOS (リリース):   /Users/<ユーザー名>/Library/Application
/// Support/Sonora App Bridge/settings.json
/// - macOS (デバッグ):   /Users/<ユーザー名>/Library/Application
/// Support/Sonora App Bridge/settings.dev.json
/// - Linux (リリース):   /home/<ユーザー名>/.config/Sonora App Bridge/settings.json
/// - Linux (デバッグ):   /home/<ユーザー名>/.config/Sonora App Bridge/settings.dev.json
static juce::File getSettingsFile()
{
    // 設定ディレクトリを取得
    juce::File configDir = getConfigDir();

// ビルドタイプごとにファイル名を切り替え
#ifdef DEBUG
    // デバッグビルドでは "settings.dev.json"
    return configDir.getChildFile("settings.dev.json");
#else
    // リリースビルドでは "settings.json"
    return configDir.getChildFile("settings.json");
#endif
}
