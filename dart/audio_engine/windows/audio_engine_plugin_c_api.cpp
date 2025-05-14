#include "include/audio_engine/audio_engine_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "audio_engine_plugin.h"

void AudioEnginePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
    audio_engine::AudioEnginePlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarManager::GetInstance()
            ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
