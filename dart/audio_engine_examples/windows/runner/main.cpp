#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "rpc_message.h"
#include "utils.h"

HWND g_hwnd;

extern "C"
{
    __declspec(dllexport) void invokeCallbackOnMainThread(ICallbackMessage *msg)
    {
        PostMessageA(g_hwnd, WM_USER_CMM_CALLBACK_MESSAGE, (WPARAM)msg, 0);
    }
}

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command)
{
    // Attach to console when present (e.g., 'flutter run') or create a
    // new console when running with a debugger.
    if(!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent())
    {
        CreateAndAttachConsole();
    }

    // Initialize COM, so that it is available for use in the library and/or
    // plugins.
    ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

    flutter::DartProject project(L"data");

    std::vector<std::string> command_line_arguments = GetCommandLineArguments();

    project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

    FlutterWindow window(project);
    Win32Window::Point origin(10, 10);
    Win32Window::Size size(1280, 720);
    if(!window.Create(L"audio_engine_examples", origin, size))
    {
        return EXIT_FAILURE;
    }
    g_hwnd = window.GetHandle();
    window.SetQuitOnClose(true);

    ::MSG msg;
    while(::GetMessage(&msg, nullptr, 0, 0))
    {
        ::TranslateMessage(&msg);
        ::DispatchMessage(&msg);
    }

    ::CoUninitialize();
    return EXIT_SUCCESS;
}
