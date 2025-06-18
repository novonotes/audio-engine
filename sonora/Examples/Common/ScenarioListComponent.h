#pragma once
#include <juce_gui_basics/juce_gui_basics.h>

#include "Scenario.h"

class ScenarioComponent : public juce::Component
{
   public:
    ScenarioComponent(const Scenario& scenario) : _scenario(scenario)
    {
        _titleLabel.setText(_scenario.title,
                            juce::NotificationType::dontSendNotification);

        _runButton.setButtonText("Run");
        _runButton.onClick = _scenario.callback;

        addAndMakeVisible(_titleLabel);
        addAndMakeVisible(_runButton);
    }

    void resized() override
    {
        auto area = getLocalBounds().reduced(5);
        auto buttonWidth = 60;
        _titleLabel.setBounds(
            area.removeFromLeft(area.getWidth() - buttonWidth));
        _runButton.setBounds(area.removeFromLeft(buttonWidth));
    }

   private:
    Scenario _scenario;
    juce::Label _titleLabel;
    juce::TextButton _runButton;
};

class ScenarioListComponent : public juce::Component
{
   public:
    ScenarioListComponent(const std::vector<Scenario>& scenarios)
    {
        for(const auto& scenario : scenarios)
        {
            auto* item = new ScenarioComponent(scenario);
            addAndMakeVisible(item);
            _scenarioComponents.add(item);
        }
    }

    void resized() override
    {
        auto area = getLocalBounds();
        int y = 0;
        const int itemHeight = 40;

        for(auto* item : _scenarioComponents)
        {
            item->setBounds(0, y, area.getWidth(), itemHeight);
            y += itemHeight;
        }

        setSize(area.getWidth(), y);
    }

   private:
    juce::OwnedArray<ScenarioComponent> _scenarioComponents;
};
