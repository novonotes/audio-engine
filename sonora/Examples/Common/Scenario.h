#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <AudioEngineCore/Utils/ExecuteAfterDelay.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <juce_core/juce_core.h>

class Scenario
{
   public:
    using CallbackFunction = std::function<void()>;

    Scenario(const juce::String& t, CallbackFunction c) : title(t), callback(c)
    {}

    juce::String title;
    CallbackFunction callback;
};

std::vector<Scenario> createScenarios(novonotes::AudioEngine& engine);
