#include "ProcessLauncher.h"

#if JUCE_MAC
#include <spawn.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
extern char **environ;
#endif

#if JUCE_WINDOWS
#include <windows.h>
#endif

#if JUCE_LINUX
#include <unistd.h>
#include <sys/wait.h>
#endif

namespace novonotes
{

bool ProcessLauncher::launchDetached(const juce::String& command,
                                     const juce::StringArray& arguments,
                                     const juce::String& workingDirectory)
{
#if JUCE_MAC
    return launchDetachedMacOS(command, arguments, workingDirectory);
#elif JUCE_WINDOWS
    return launchDetachedWindows(command, arguments, workingDirectory);
#elif JUCE_LINUX
    return launchDetachedLinux(command, arguments, workingDirectory);
#else
    // その他のプラットフォームでは通常のChildProcessを使用
    juce::ChildProcess child;
    juce::StringArray fullCommand;
    fullCommand.add(command);
    fullCommand.addArray(arguments);
    return child.start(fullCommand, 0);
#endif
}

#if JUCE_MAC
bool ProcessLauncher::launchDetachedMacOS(const juce::String& command,
                                          const juce::StringArray& arguments,
                                          const juce::String& workingDirectory)
{
    // ダブルfork技法を使用して完全にdetachされたプロセスを作成
    pid_t pid = fork();
    
    if (pid < 0)
    {
        // fork失敗
        DBG("First fork failed");
        return false;
    }
    else if (pid == 0)
    {
        // 最初の子プロセス
        
        // 新しいセッションを作成
        setsid();
        
        // 2回目のfork
        pid_t pid2 = fork();
        
        if (pid2 < 0)
        {
            // 2回目のfork失敗
            _exit(1);
        }
        else if (pid2 == 0)
        {
            // 孫プロセス（実際に実行するプロセス）
            
            // 作業ディレクトリを変更
            if (workingDirectory.isNotEmpty())
            {
                chdir(workingDirectory.toRawUTF8());
            }
            
            // 標準入出力を /dev/null にリダイレクト
            // プラグインからの出力を防ぐため
            int devNull = open("/dev/null", O_RDWR);
            if (devNull >= 0)
            {
                dup2(devNull, STDIN_FILENO);
                dup2(devNull, STDOUT_FILENO);
                dup2(devNull, STDERR_FILENO);
                if (devNull > 2)
                    close(devNull);
            }
            
            // 不要なファイルディスクリプタを閉じる
            for (int fd = 3; fd < 1024; fd++)
            {
                close(fd);
            }
            
            // コマンドと引数を準備
            juce::StringArray fullArgs;
            fullArgs.add(command);
            fullArgs.addArray(arguments);
            
            // execv用の引数配列を作成
            std::vector<std::string> argStrings;
            for (const auto& arg : fullArgs)
            {
                argStrings.push_back(arg.toStdString());
            }
            
            std::vector<char*> argv;
            for (auto& str : argStrings)
            {
                argv.push_back(const_cast<char*>(str.c_str()));
            }
            argv.push_back(nullptr);
            
            // プロセスを実行
            execv(command.toRawUTF8(), argv.data());
            
            // execvが失敗した場合
            _exit(1);
        }
        else
        {
            // 最初の子プロセスはすぐに終了
            _exit(0);
        }
    }
    else
    {
        // 親プロセス
        // 最初の子プロセスの終了を待つ
        int status;
        waitpid(pid, &status, 0);
        
        if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
        {
            return true;
        }
        else
        {
            DBG("Failed to launch detached process");
            return false;
        }
    }
}
#endif

#if JUCE_WINDOWS
bool ProcessLauncher::launchDetachedWindows(const juce::String& command,
                                            const juce::StringArray& arguments,
                                            const juce::String& workingDirectory)
{
    // コマンドラインを構築
    juce::String commandLine = "\"" + command + "\"";
    for (const auto& arg : arguments)
    {
        commandLine += " ";
        // 引数にスペースが含まれる場合はクォートで囲む
        if (arg.containsChar(' '))
        {
            commandLine += "\"" + arg + "\"";
        }
        else
        {
            commandLine += arg;
        }
    }
    
    STARTUPINFOW si = {};
    si.cb = sizeof(si);
    PROCESS_INFORMATION pi = {};
    
    // DETACHED_PROCESS フラグで親プロセスから独立
    // CREATE_NEW_PROCESS_GROUP で新しいプロセスグループを作成
    DWORD creationFlags = DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP;
    
    BOOL result = CreateProcessW(
        nullptr,                                        // アプリケーション名
        const_cast<LPWSTR>(commandLine.toWideCharPointer()), // コマンドライン
        nullptr,                                        // プロセスのセキュリティ属性
        nullptr,                                        // スレッドのセキュリティ属性
        FALSE,                                          // ハンドルを継承しない
        creationFlags,                                  // 作成フラグ
        nullptr,                                        // 環境変数
        workingDirectory.isNotEmpty() ? workingDirectory.toWideCharPointer() : nullptr, // 作業ディレクトリ
        &si,                                           // STARTUPINFO
        &pi                                            // PROCESS_INFORMATION
    );
    
    if (result)
    {
        // ハンドルを閉じる（プロセスは独立して実行される）
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
        return true;
    }
    
    return false;
}
#endif

#if JUCE_LINUX
bool ProcessLauncher::launchDetachedLinux(const juce::String& command,
                                          const juce::StringArray& arguments,
                                          const juce::String& workingDirectory)
{
    // ダブルfork技法を使用
    pid_t pid = fork();
    
    if (pid < 0)
    {
        // fork失敗
        return false;
    }
    else if (pid == 0)
    {
        // 最初の子プロセス
        
        // 新しいセッションを作成
        setsid();
        
        // 2回目のfork
        pid_t pid2 = fork();
        
        if (pid2 < 0)
        {
            _exit(1);
        }
        else if (pid2 == 0)
        {
            // 孫プロセス（実際に実行するプロセス）
            
            // 作業ディレクトリを変更
            if (workingDirectory.isNotEmpty())
            {
                chdir(workingDirectory.toRawUTF8());
            }
            
            // 標準入出力をリダイレクト
            int devNull = open("/dev/null", O_RDWR);
            dup2(devNull, STDIN_FILENO);
            dup2(devNull, STDOUT_FILENO);
            dup2(devNull, STDERR_FILENO);
            close(devNull);
            
            // コマンドと引数を準備
            juce::StringArray fullArgs;
            fullArgs.add(command);
            fullArgs.addArray(arguments);
            
            std::vector<const char*> argv;
            for (const auto& arg : fullArgs)
            {
                argv.push_back(arg.toRawUTF8());
            }
            argv.push_back(nullptr);
            
            // プロセスを実行
            execvp(command.toRawUTF8(), const_cast<char* const*>(argv.data()));
            
            // execvpが失敗した場合
            _exit(1);
        }
        else
        {
            // 最初の子プロセスはすぐに終了
            _exit(0);
        }
    }
    else
    {
        // 親プロセス
        // 最初の子プロセスの終了を待つ
        int status;
        waitpid(pid, &status, 0);
        return WIFEXITED(status) && WEXITSTATUS(status) == 0;
    }
}
#endif

} // namespace novonotes