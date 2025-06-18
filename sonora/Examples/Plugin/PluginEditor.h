#pragma once

#include <juce_gui_basics/juce_gui_basics.h>

#include "ScenarioListComponent.h"

class PluginEditor : public juce::AudioProcessorEditor
{
   public:
    PluginEditor(PluginProcessor& p, const std::vector<Scenario>& scenarios)
        : AudioProcessorEditor(&p)
        , _pluginProcessor(p)
    {
        _scenarioListComponent =
            std::make_unique<ScenarioListComponent>(scenarios);

        _viewport.setViewedComponent(_scenarioListComponent.get(), true);
        addAndMakeVisible(_viewport);

        setSize(400, 300);
    }

    ~PluginEditor() override {}

    void paint(juce::Graphics& g) override
    {
        g.fillAll(juce::Colours::darkgrey);
    }

    void resized() override
    {
        _viewport.setBounds(getLocalBounds());

        auto scrollbarThickness = _viewport.getScrollBarThickness();
        _scenarioListComponent->setSize(getWidth() - scrollbarThickness,
                                        _scenarioListComponent->getHeight());
    }

   private:
    PluginProcessor& _pluginProcessor;
    juce::Viewport _viewport;
    std::unique_ptr<ScenarioListComponent> _scenarioListComponent;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(PluginEditor)
};
