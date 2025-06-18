//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <audio_engine/audio_engine_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) audio_engine_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AudioEnginePlugin");
  audio_engine_plugin_register_with_registrar(audio_engine_registrar);
}
