#ifndef FLUTTER_PLUGIN_AUDIO_ENGINE_PLUGIN_H_
#define FLUTTER_PLUGIN_AUDIO_ENGINE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace audio_engine
{

class AudioEnginePlugin : public flutter::Plugin
{
   public:
    static void RegisterWithRegistrar(
        flutter::PluginRegistrarWindows *registrar);

    AudioEnginePlugin(flutter::PluginRegistrarWindows *registrar);

    virtual ~AudioEnginePlugin();

    // Disallow copy and assign.
    AudioEnginePlugin(const AudioEnginePlugin &) = delete;
    AudioEnginePlugin &operator=(const AudioEnginePlugin &) = delete;

    // Called when a method is called on this plugin's channel from Dart.
    void HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

   private:
    // The ID of the WindowProc delegate registration.
    int window_proc_id_ = -1;
    // The registrar for this plugin.
    flutter::PluginRegistrarWindows *registrar_;
};

}  // namespace audio_engine

#endif  // FLUTTER_PLUGIN_AUDIO_ENGINE_PLUGIN_H_
