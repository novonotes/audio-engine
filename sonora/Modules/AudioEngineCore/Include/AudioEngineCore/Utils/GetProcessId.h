
#include <cstdint>  // For uint32_t
#include <iostream>

#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#elif defined(__APPLE__) || defined(__linux__)
#include <unistd.h>
#endif

inline static uint32_t getProcessId()
{
    uint32_t pid = 0;

#if defined(_WIN32) || defined(_WIN64)
    pid = static_cast<uint32_t>(GetCurrentProcessId());
#elif defined(__APPLE__) || defined(__linux__)
    pid = static_cast<uint32_t>(getpid());
#endif

    return pid;
}
