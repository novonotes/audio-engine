
#pragma once
#include "PluginProcessor.h"

using namespace juce;

namespace novonotes
{

namespace PlayHeadHelpers
{
// Quick-and-dirty function to format a timecode string
static inline String timeToTimecodeString(double seconds)
{
    auto millisecs = roundToInt(seconds * 1000.0);
    auto absMillisecs = std::abs(millisecs);

    String ret;
    ret << millisecs / 3600000 << ":" << (absMillisecs / 60000) % 60 << ":"
        << (absMillisecs / 1000) % 60 << "." << absMillisecs % 1000;
    return ret;
}

// Quick-and-dirty function to format a bars/beats string
static inline String quarterNotePositionToBarsBeatsString(double quarterNotes,
                                                          int numerator,
                                                          int denominator)
{
    if(numerator == 0 || denominator == 0) return "1|1|000";

    auto quarterNotesPerBar = ((double)numerator * 4.0 / (double)denominator);
    auto beats = (fmod(quarterNotes, quarterNotesPerBar) / quarterNotesPerBar) *
                 numerator;

    auto bar = (int)(quarterNotes / quarterNotesPerBar + 1);
    auto beat = ((int)beats) + 1;
    auto ticks = ((int)(fmod(beats, 1.0) * 960.0 + 0.5));

    String ret;
    ret << bar << "|" << beat << "|" << ticks;
    return ret;
}

// Returns a textual description of a CurrentPositionInfo
static inline String getTimecodeDisplay(
    const AudioPlayHead::CurrentPositionInfo& pos)
{
    MemoryOutputStream displayText;

    displayText << String(pos.bpm, 2) << " bpm, " << pos.timeSigNumerator << '/'
                << pos.timeSigDenominator << "  -  "
                << timeToTimecodeString(pos.timeInSeconds) << "  -  "
                << quarterNotePositionToBarsBeatsString(pos.ppqPosition,
                                                        pos.timeSigNumerator,
                                                        pos.timeSigDenominator);

    if(pos.isRecording)
        displayText << "  (recording)";
    else if(pos.isPlaying)
        displayText << "  (playing)";
    else
        displayText << "  (stopped)";

    return displayText.toString();
}
}  // namespace PlayHeadHelpers

/// プラグイン開発用のエディター。
/// リリース版では表示されない。
class PluginDevEditor
    : public AudioProcessorEditor
    , public juce::Timer
{
   public:
    PluginDevEditor(PluginProcessor& p)
        : AudioProcessorEditor(p)
        , _pluginProcessor(p)
        , _engine(p.getEngine())
    {
        setSize(400, 300);

        _playPauseButton.onClick = [this] {
            juce::Logger::writeToLog("Test Tone");
            _engine.getDebugUtilityService().testTone();
        };

        addAndMakeVisible(_playPauseButton);

        _positionInfo.resetToDefault();
        _editPositionInfo.resetToDefault();

        startTimerHz(25);
    }

    ~PluginDevEditor() override {}

    void paint(Graphics& g) override
    {
        g.fillAll(Colours::darkgrey);

        auto r = getLocalBounds();

        String text;
        // clang-format off
        text << "Sonora App Bridge Dev Editor" << newLine << newLine
             << "Host Info:" << newLine
             << PlayHeadHelpers::getTimecodeDisplay(_positionInfo)
             << newLine << newLine
             << "Version: "
             << _pluginProcessor.getVersion();
        // clang-format on
        g.setColour(Colours::white);
        g.setFont(15.0f);
        g.drawFittedText(text, r.reduced(10), Justification::topLeft, 5);
    }

    void resized() override
    {
        auto r = getLocalBounds();
        auto topR = r.removeFromBottom(30);
        _playPauseButton.setBounds(topR.reduced(2));
    }

   private:
    void timerCallback() override
    {
        _positionInfo = _engine.getTransportService().getPlayheadPosition();
        repaint();
    }

    PluginProcessor& _pluginProcessor;
    AudioEngine& _engine;
    TextButton _playPauseButton{"Test Tone"};
    AudioPlayHead::CurrentPositionInfo _positionInfo, _editPositionInfo;
};

}  // namespace novonotes
