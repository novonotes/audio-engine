#pragma once

#include <string>
#include <thread>

#ifdef _WIN32
#include <tlhelp32.h>
#include <windows.h>
#elif defined(__APPLE__) || defined(__linux__)
#include <sys/types.h>
#include <unistd.h>
#ifdef __APPLE__
#include <mach/mach.h>
#endif
#endif

/**
 * @brief 現在のプロセスのメインスレッドIDを取得する
 *
 * @return std::string メインスレッドIDを文字列で返す。エラーの場合は空文字列
 *
 * @example
 * // 現在のプロセスのメインスレッドIDを取得する
 * std::string mainThreadId = getMainThreadId();
 */
inline static std::string getMainThreadId()
{
#ifdef _WIN32
    DWORD dwOwnerPID = GetCurrentProcessId();
    THREADENTRY32 te32;
    std::string mainThreadId = "";

    HANDLE hThreadSnap = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if(hThreadSnap == INVALID_HANDLE_VALUE)
    {
        return mainThreadId;
    }

    te32.dwSize = sizeof(THREADENTRY32);

    if(Thread32First(hThreadSnap, &te32))
    {
        do
        {
            if(te32.th32OwnerProcessID == dwOwnerPID)
            {
                mainThreadId = std::to_string(te32.th32ThreadID);
                break;
            }
        } while(Thread32Next(hThreadSnap, &te32));
    }

    CloseHandle(hThreadSnap);
    return mainThreadId;

#elif defined(__APPLE__)
    mach_port_t machTask = mach_task_self();
    thread_act_array_t threadList;
    mach_msg_type_number_t threadCount;

    if(task_threads(machTask, &threadList, &threadCount) != KERN_SUCCESS)
    {
        return "Error: Unable to get thread list";
    }

    // メインスレッドは通常、リストの最初のスレッド
    thread_t mainThread = threadList[0];
    uint64_t tid;

    if(pthread_threadid_np(pthread_from_mach_thread_np(mainThread), &tid) != 0)
    {
        vm_deallocate(machTask, (vm_address_t)threadList,
                      threadCount * sizeof(thread_t));
        return "Error: Unable to get thread ID";
    }

    vm_deallocate(machTask, (vm_address_t)threadList,
                  threadCount * sizeof(thread_t));
    return std::to_string(tid);

#elif defined(__linux__)
    pid_t tid = gettid();
    return std::to_string(tid);

#else
    // その他のプラットフォームでは、std::this_thread::get_id()を使用
    std::thread::id threadId = std::this_thread::get_id();
    return std::to_string(threadId);
#endif
}
