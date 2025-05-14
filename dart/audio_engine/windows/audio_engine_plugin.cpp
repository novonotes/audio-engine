#include "audio_engine_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#include "callback_message.h"

namespace audio_engine
{

// static
void AudioEnginePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar)
{
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "audio_engine",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<AudioEnginePlugin>(registrar);

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result) {
            plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
}

HWND g_hwnd = nullptr;

AudioEnginePlugin::AudioEnginePlugin(flutter::PluginRegistrarWindows *registrar)
    : registrar_(registrar)
{
    window_proc_id_ = registrar->RegisterTopLevelWindowProcDelegate(
        [](HWND hwnd, UINT message, WPARAM wparam, LPARAM lparam) {
            std::optional<LRESULT> result;
            if(!g_hwnd)
            {
                g_hwnd = hwnd;
            }
            switch(message)
            {
                case WM_USER_NOVONOTES_CALLBACK_MESSAGE:
                {
                    auto *msg = (ICallbackMessage *)wparam;

                    msg->invoke();
                    msg->release();
                    result = 0;
                    break;
                }
            }
            return result;
        });
}

AudioEnginePlugin::~AudioEnginePlugin()
{
    registrar_->UnregisterTopLevelWindowProcDelegate(window_proc_id_);
}

void AudioEnginePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
{
    if(method_call.method_name().compare("getPlatformVersion") == 0)
    {
        std::ostringstream version_stream;
        version_stream << "Windows ";
        if(IsWindows10OrGreater())
        {
            version_stream << "10+";
        }
        else if(IsWindows8OrGreater())
        {
            version_stream << "8";
        }
        else if(IsWindows7OrGreater())
        {
            version_stream << "7";
        }
        result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if(method_call.method_name().compare("getTopLevelWindowHandle") == 0)
    {
        auto address = reinterpret_cast<intptr_t>(g_hwnd);
        result->Success(flutter::EncodableValue(address));
    }
    else
    {
        result->NotImplemented();
    }
}

}  // namespace audio_engine
