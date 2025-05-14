#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <juce_gui_extra/juce_gui_extra.h>

#include "ScenarioListComponent.h"

class MainComponent final : public juce::Component
{
   public:
    //==============================================================================
    MainComponent(novonotes::AudioEngine& engine);

    //==============================================================================
    void paint(juce::Graphics&) override;
    void resized() override;

   private:
    //==============================================================================

    juce::Viewport _viewport;
    std::unique_ptr<ScenarioListComponent> _scenarioListComponent;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(MainComponent)
};
