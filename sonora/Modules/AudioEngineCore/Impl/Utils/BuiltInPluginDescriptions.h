#pragma once

#include <juce_audio_processors/juce_audio_processors.h>
#include <tracktion_engine/tracktion_engine.h>

#include <unordered_map>
#include <vector>

namespace novonotes
{
// getSupportedBuiltInPluginDescriptions の宣言
std::vector<juce::PluginDescription> getSupportedBuiltInPluginDescriptions();

// convertToXmlTypeName の宣言
juce::String convertToXmlTypeName(const juce::String& pluginId);
}  // namespace novonotes
