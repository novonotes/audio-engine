#include "BuiltInPluginDescriptions.h"

#include <tracktion_engine/tracktion_engine.h>

namespace te = tracktion;

namespace novonotes
{
namespace
{
/// getSupportedBuiltInPluginDescriptions の内部のみで使用する
template <class PluginClass>
juce::PluginDescription createBuiltInPluginDescription(bool isSynth)
{
    juce::PluginDescription desc;
    desc.name = TRANS(PluginClass::getPluginName());
    desc.pluginFormatName = "TracktionInternal";
    desc.category = isSynth ? TRANS("Synth") : TRANS("Effect");
    desc.manufacturerName = "Tracktion Software Corporation";
    desc.fileOrIdentifier = PluginClass::xmlTypeName;
    desc.version = te::Engine::getVersion();
    desc.isInstrument = isSynth;
    return desc;
}
}  // namespace

std::vector<juce::PluginDescription> getSupportedBuiltInPluginDescriptions()
{
    static std::vector<juce::PluginDescription> pluginDescriptions;

    if(pluginDescriptions.empty())
    {
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::VolumeAndPanPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::ReverbPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::ChorusPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::CompressorPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::DelayPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::EqualiserPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::FourOscPlugin>(true));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::ImpulseResponsePlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::LowPassPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::MidiModifierPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::MidiPatchBayPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::PatchBayPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::PhaserPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::PitchShiftPlugin>(false));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::SamplerPlugin>(true));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::ToneGeneratorPlugin>(true));
        pluginDescriptions.push_back(
            createBuiltInPluginDescription<te::LevelMeterPlugin>(false));
    }

    return pluginDescriptions;
}

juce::String convertToXmlTypeName(const juce::String& pluginId)
{
    if(pluginId.startsWith("VST"))
    {
        return te::ExternalPlugin::xmlTypeName;
    }

    static const std::unordered_map<juce::String, juce::String> deviceTypeMap =
        {{"TracktionInternal-Volume and Pan-cfaae71a-0",
          te::VolumeAndPanPlugin::xmlTypeName},
         {"TracktionInternal-Reverb-c84ee9d2-0", te::ReverbPlugin::xmlTypeName},
         {"TracktionInternal-Chorus-aedd81a6-0", te::ChorusPlugin::xmlTypeName},
         {"TracktionInternal-Compressor/Limiter-e9faa8c5-0",
          te::CompressorPlugin::xmlTypeName},
         {"TracktionInternal-Delay-5b0b983-0", te::DelayPlugin::xmlTypeName},
         {"TracktionInternal-4-Band Equaliser-6b895ef5-0",
          te::EqualiserPlugin::xmlTypeName},
         {"TracktionInternal-4OSC-19524b-0", te::FourOscPlugin::xmlTypeName},
         {"TracktionInternal-Impulse Response-dffb5856-0",
          te::ImpulseResponsePlugin::xmlTypeName},
         {"TracktionInternal-Latency Tester-d99b775d-0",
          te::LatencyPlugin::xmlTypeName},
         {"TracktionInternal-Low/High-Pass Filter-154c3d65-0",
          te::LowPassPlugin::xmlTypeName},
         {"TracktionInternal-MIDI Modifier-745cd918-0",
          te::MidiModifierPlugin::xmlTypeName},
         {"TracktionInternal-MIDI Patch Bay-de8888f3-0",
          te::MidiPatchBayPlugin::xmlTypeName},
         {"TracktionInternal-Patch Bay-495616d2-0",
          te::PatchBayPlugin::xmlTypeName},
         {"TracktionInternal-Phaser-c5062657-0", te::PhaserPlugin::xmlTypeName},
         {"TracktionInternal-Pitch Shifter-88d30d4f-0",
          te::PitchShiftPlugin::xmlTypeName},
         {"TracktionInternal-Sampler-6f274008-0",
          te::SamplerPlugin::xmlTypeName},
         {"TracktionInternal-Tone Generator-4d30d181-0",
          te::ToneGeneratorPlugin::xmlTypeName},
         {"TracktionInternal-Freeze Point-7d573139-0",
          te::FreezePointPlugin::xmlTypeName},
         {"TracktionInternal-Insert-b970c2b9-0", te::InsertPlugin::xmlTypeName},
         {"TracktionInternal-Level Meter-6219b84-0",
          te::LevelMeterPlugin::xmlTypeName},
         {"TracktionInternal-Text-36452d-0", te::TextPlugin::xmlTypeName},
         {"TracktionInternal-Aux Send-d9b4484c-0",
          te::AuxSendPlugin::xmlTypeName},
         {"TracktionInternal-Aux Return-3c1194f4-0",
          te::AuxReturnPlugin::xmlTypeName}};

    auto it = deviceTypeMap.find(pluginId);
    if(it != deviceTypeMap.end())
    {
        return it->second;
    }

    return "";
}

}  // namespace novonotes
