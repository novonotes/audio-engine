#include "MainComponent.h"

#include <juce_graphics/juce_graphics.h>

//==============================================================================
MainComponent::MainComponent(novonotes::AudioEngine& engine)
{
    auto scenarios = createScenarios(engine);
    _scenarioListComponent = std::make_unique<ScenarioListComponent>(scenarios);

    _viewport.setViewedComponent(_scenarioListComponent.get(), true);
    addAndMakeVisible(_viewport);

    setSize(600, 400);
}

//==============================================================================
void MainComponent::paint(juce::Graphics& g)
{
    g.fillAll(juce::Colours::darkgrey);
}

void MainComponent::resized()
{
    _viewport.setBounds(getLocalBounds());

    auto scrollbarThickness = _viewport.getScrollBarThickness();
    _scenarioListComponent->setSize(getWidth() - scrollbarThickness,
                                    _scenarioListComponent->getHeight());
}
