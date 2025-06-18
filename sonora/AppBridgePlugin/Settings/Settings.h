#pragma once

#include <juce_core/juce_core.h>

namespace novonotes
{

class Settings
{
   public:
    static Settings initialize();
    explicit Settings(const juce::var& json);

    juce::String getCommand() const;
    juce::String getCwd() const;
    std::vector<juce::String> getArgs() const;

   private:
    juce::var _json;
    static juce::var createDefaultSettings();
};

}  // namespace novonotes
