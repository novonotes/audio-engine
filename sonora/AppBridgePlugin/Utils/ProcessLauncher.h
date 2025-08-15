#pragma once

#include <juce_core/juce_core.h>

namespace novonotes
{
/**
 * プロセスをdetachedモードで起動するユーティリティクラス
 * 
 * 通常のChildProcessと異なり、親プロセスから完全に独立したプロセスを起動します。
 * これにより、親プロセスが終了してもzombieプロセスが残らないようになります。
 */
class ProcessLauncher
{
public:
    /**
     * プロセスをdetachedモードで起動
     * 
     * @param command 実行ファイルのパス
     * @param arguments コマンドライン引数
     * @param workingDirectory 作業ディレクトリ（空の場合は現在のディレクトリ）
     * @return 起動に成功した場合はtrue
     */
    static bool launchDetached(const juce::String& command,
                               const juce::StringArray& arguments,
                               const juce::String& workingDirectory = {});
    
private:
#if JUCE_MAC
    static bool launchDetachedMacOS(const juce::String& command,
                                    const juce::StringArray& arguments,
                                    const juce::String& workingDirectory);
#endif
    
#if JUCE_WINDOWS
    static bool launchDetachedWindows(const juce::String& command,
                                      const juce::StringArray& arguments,
                                      const juce::String& workingDirectory);
#endif
    
#if JUCE_LINUX
    static bool launchDetachedLinux(const juce::String& command,
                                    const juce::StringArray& arguments,
                                    const juce::String& workingDirectory);
#endif
};

} // namespace novonotes