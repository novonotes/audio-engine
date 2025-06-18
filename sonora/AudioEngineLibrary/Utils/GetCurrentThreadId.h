#pragma once

#include <sstream>
#include <string>

#ifdef _WIN32
#include <windows.h>
#else
#include <thread>
#endif

// Helper function to get current thread id
static std::string getCurrentThreadId()
{
#ifdef _WIN32
    return std::to_string(GetCurrentThreadId());
#elif defined(__APPLE__)
    uint64_t tid;
    pthread_threadid_np(nullptr, &tid);
    return std::to_string(tid);
#else
    std::stringstream ss;
    ss << std::this_thread::get_id();
    return ss.str();
#endif
}
