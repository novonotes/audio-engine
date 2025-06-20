/*
    ,--.                     ,--.     ,--.  ,--.
  ,-'  '-.,--.--.,--,--.,---.|  |,-.,-'  '-.`--' ,---. ,--,--,      Copyright
  2018
  '-.  .-'|  .--' ,-.  | .--'|     /'-.  .-',--.| .-. ||      \   Tracktion
  Software |  |  |  |  \ '-'  \ `--.|  \  \  |  |  |  |' '-' '|  ||  |
  Corporation
    `---' `--'   `--`--'`---'`--'`--' `---' `--' `---' `--''--'
  www.tracktion.com
*/

#pragma once

#include <tracktion_engine/tracktion_engine.h>

namespace te = tracktion;
using namespace std::literals;
using namespace juce;

//==============================================================================
namespace Helpers
{
static inline void addAndMakeVisible(Component& parent,
                                     const Array<Component*>& children)
{
    for(auto c : children) parent.addAndMakeVisible(c);
}

static inline String getStringOrDefault(const String& stringToTest,
                                        const String& stringToReturnIfEmpty)
{
    return stringToTest.isEmpty() ? stringToReturnIfEmpty : stringToTest;
}

static inline File findRecentEdit(const File& dir)
{
    auto files = dir.findChildFiles(File::findFiles, false, "*.tracktionedit");

    if(files.size() > 0)
    {
        files.sort();
        return files.getLast();
    }

    return {};
}
}  // namespace Helpers

//==============================================================================
namespace PlayHeadHelpers
{
// Quick-and-dirty function to format a timecode string
static inline String timeToTimecodeString(double seconds)
{
    auto millisecs = roundToInt(seconds * 1000.0);
    auto absMillisecs = std::abs(millisecs);

    return String::formatted("%02d:%02d:%02d.%03d", millisecs / 3600000,
                             (absMillisecs / 60000) % 60,
                             (absMillisecs / 1000) % 60, absMillisecs % 1000);
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

    auto bar = ((int)quarterNotes) / quarterNotesPerBar + 1;
    auto beat = ((int)beats) + 1;
    auto ticks = ((int)(fmod(beats, 1.0) * 960.0 + 0.5));

    return String::formatted("%d|%d|%03d", bar, beat, ticks);
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

//==============================================================================
namespace EngineHelpers
{
inline te::Project::Ptr createTempProject(te::Engine& engine)
{
    auto file = engine.getTemporaryFileManager()
                    .getTempDirectory()
                    .getChildFile("temp_project")
                    .withFileExtension(te::projectFileSuffix);
    te::ProjectManager::TempProject tempProject(engine.getProjectManager(),
                                                file, true);
    return tempProject.project;
}

inline void showAudioDeviceSettings(te::Engine& engine)
{
    DialogWindow::LaunchOptions o;
    o.dialogTitle = TRANS("Audio Settings");
    o.dialogBackgroundColour = LookAndFeel::getDefaultLookAndFeel().findColour(
        ResizableWindow::backgroundColourId);
    o.content.setOwned(new AudioDeviceSelectorComponent(
        engine.getDeviceManager().deviceManager, 0, 512, 1, 512, false, false,
        true, true));
    o.content->setSize(400, 600);
    o.launchAsync();
}

inline void browseForAudioFile(
    te::Engine& engine, std::function<void(const File&)> fileChosenCallback)
{
    auto fc = std::make_shared<FileChooser>(
        "Please select an audio file to load...",
        engine.getPropertyStorage().getDefaultLoadSaveDirectory(
            "pitchAndTimeExample"),
        engine.getAudioFileFormatManager()
            .readFormatManager.getWildcardForAllFormats());

    fc->launchAsync(
        FileBrowserComponent::openMode + FileBrowserComponent::canSelectFiles,
        [fc, &engine,
         callback = std::move(fileChosenCallback)](const FileChooser&) {
            const auto f = fc->getResult();

            if(f.existsAsFile())
                engine.getPropertyStorage().setDefaultLoadSaveDirectory(
                    "pitchAndTimeExample", f.getParentDirectory());

            callback(f);
        });
}

inline void removeAllClips(te::AudioTrack& track)
{
    auto clips = track.getClips();

    for(int i = clips.size(); --i >= 0;)
        clips.getUnchecked(i)->removeFromParent();
}

inline te::AudioTrack* getOrInsertAudioTrackAt(te::Edit& edit, int index)
{
    edit.ensureNumberOfAudioTracks(index + 1);
    return te::getAudioTracks(edit)[index];
}

inline te::WaveAudioClip::Ptr loadAudioFileAsClip(te::Edit& edit,
                                                  const File& file)
{
    // Find the first track and delete all clips from it
    if(auto track = getOrInsertAudioTrackAt(edit, 0))
    {
        removeAllClips(*track);

        // Add a new clip to this track
        te::AudioFile audioFile(edit.engine, file);

        if(audioFile.isValid())
            if(auto newClip = track->insertWaveClip(
                   file.getFileNameWithoutExtension(), file,
                   {{{}, te::TimeDuration::fromSeconds(audioFile.getLength())},
                    {}},
                   false))
                return newClip;
    }

    return {};
}

template <typename ClipType>
typename ClipType::Ptr loopAroundClip(ClipType& clip)
{
    auto& transport = clip.edit.getTransport();
    transport.setLoopRange(clip.getEditTimeRange());
    transport.looping = true;
    transport.setPosition(0s);
    transport.play(false);

    return clip;
}

enum class ReturnToStart
{
    no,
    yes
};

inline void togglePlay(te::Edit& edit, ReturnToStart rts = ReturnToStart::no)
{
    auto& transport = edit.getTransport();

    if(transport.isPlaying())
        transport.stop(false, false);
    else
    {
        if(rts == ReturnToStart::yes)
            transport.playFromStart(true);
        else
            transport.play(false);
    }
}

inline void toggleRecord(te::Edit& edit)
{
    auto& transport = edit.getTransport();

    if(transport.isRecording())
        transport.stop(true, false);
    else
        transport.record(false);
}

inline void armTrack(te::AudioTrack& t, bool arm, int position = 0)
{
    auto& edit = t.edit;
    for(auto instance : edit.getAllInputDevices())
        if(te::isOnTargetTrack(*instance, t, position))
            instance->setRecordingEnabled(t.itemID, arm);
}

inline bool isTrackArmed(te::AudioTrack& t, int position = 0)
{
    auto& edit = t.edit;
    for(auto instance : edit.getAllInputDevices())
        if(te::isOnTargetTrack(*instance, t, position))
            return instance->isRecordingEnabled(t.itemID);

    return false;
}

inline bool isInputMonitoringEnabled(te::AudioTrack& t, int position = 0)
{
    for(auto instance : t.edit.getAllInputDevices())
        if(te::isOnTargetTrack(*instance, t, position))
            return instance->isLivePlayEnabled(t);

    return false;
}

inline void enableInputMonitoring(te::AudioTrack& t, bool im, int position = 0)
{
    if(isInputMonitoringEnabled(t, position) != im)
    {
        for(auto instance : t.edit.getAllInputDevices())
        {
            if(te::isOnTargetTrack(*instance, t, position))
            {
                if(auto mode = instance->getInputDevice().getMonitorMode();
                   mode == te::InputDevice::MonitorMode::on ||
                   mode == te::InputDevice::MonitorMode::off)
                {
                    instance->getInputDevice().setMonitorMode(
                        mode == te::InputDevice::MonitorMode::on
                            ? te::InputDevice::MonitorMode::off
                            : te::InputDevice::MonitorMode::on);
                }
            }
        }
    }
}

inline bool trackHasInput(te::AudioTrack& t, int position = 0)
{
    auto& edit = t.edit;
    for(auto instance : edit.getAllInputDevices())
        if(te::isOnTargetTrack(*instance, t, position)) return true;

    return false;
}

inline std::unique_ptr<juce::KnownPluginList::PluginTree> createPluginTree(
    te::Engine& engine)
{
    auto& list = engine.getPluginManager().knownPluginList;

    if(auto tree = list.createTree(list.getTypes(),
                                   KnownPluginList::sortByManufacturer))
        return tree;

    return {};
}

}  // namespace EngineHelpers

//==============================================================================
class FlaggedAsyncUpdater : public AsyncUpdater
{
   public:
    //==============================================================================
    void markAndUpdate(bool& flag)
    {
        flag = true;
        triggerAsyncUpdate();
    }

    bool compareAndReset(bool& flag) noexcept
    {
        if(!flag) return false;

        flag = false;
        return true;
    }
};

//==============================================================================
struct Thumbnail : public Component
{
    Thumbnail(te::TransportControl& tc) : transport(tc)
    {
        cursorUpdater.setCallback([this] {
            updateCursorPosition();

            if(smartThumbnail.isGeneratingProxy() ||
               smartThumbnail.isOutOfDate())
                repaint();
        });
        cursor.setFill(findColour(Label::textColourId));
        addAndMakeVisible(cursor);

        pendingCursorTo.setFill(juce::Colours::cyan);
        addChildComponent(pendingCursorTo);

        pendingCursorAt.setFill(juce::Colours::lightgreen);
        addChildComponent(pendingCursorAt);
    }

    void start() { cursorUpdater.startTimerHz(25); }

    void setFile(const te::AudioFile& file)
    {
        smartThumbnail.setNewFile(file);
        cursorUpdater.startTimerHz(25);
        repaint();
    }

    void setQuantisation(std::optional<int> numBars)
    {
        quantisationNumBars = numBars;
    }

    void paint(Graphics& g) override
    {
        auto r = getLocalBounds();
        const auto colour = findColour(Label::textColourId);

        if(smartThumbnail.isGeneratingProxy())
        {
            g.setColour(colour.withMultipliedBrightness(0.9f));
            g.drawText("Creating proxy: " +
                           String(roundToInt(smartThumbnail.getProxyProgress() *
                                             100.0f)) +
                           "%",
                       r, Justification::centred);
        }
        else
        {
            const float brightness =
                smartThumbnail.isOutOfDate() ? 0.4f : 0.66f;
            g.setColour(colour.withMultipliedBrightness(brightness));
            smartThumbnail.drawChannels(
                g, r,
                {0s, te::TimePosition::fromSeconds(
                         smartThumbnail.getTotalLength())},
                1.0f);
        }
    }

    void mouseDown(const MouseEvent& e) override
    {
        positionToJumpAt = {};

        transport.setUserDragging(true);
        mouseDrag(e);
    }

    void mouseDrag(const MouseEvent& e) override
    {
        if(!e.mouseWasDraggedSinceMouseDown()) return;

        jassert(getWidth() > 0);
        const float proportion = e.position.x / getWidth();
        transport.setPosition(toPosition(transport.getLoopRange().getLength()) *
                              proportion);
    }

    void mouseUp(const MouseEvent& e) override
    {
        transport.setUserDragging(false);

        if(e.mouseWasDraggedSinceMouseDown()) return;

        if(auto epc = transport.edit.getCurrentPlaybackContext())
        {
            auto& ts = transport.edit.tempoSequence;

            // Simple quantisation for demo purposes here
            //  1. Quantise the position to jump to
            //  2. Quantise the time to jump to it
            const float proportion = e.position.x / getWidth();
            auto positionToJumpTo =
                toPosition(transport.getLoopRange().getLength()) * proportion;

            if(quantisationNumBars)
            {
                positionToJumpTo = roundToNearest(
                    toPosition(transport.getLoopRange().getLength()) *
                        proportion,
                    ts, *quantisationNumBars);
                positionToJumpAt =
                    roundUp(epc->getPosition(), ts, *quantisationNumBars);
            }
            else
            {
                positionToJumpAt = {};
            }

            epc->postPosition(positionToJumpTo, positionToJumpAt);
        }
    }

   private:
    te::TransportControl& transport;
    te::SmartThumbnail smartThumbnail{
        transport.engine, te::AudioFile(transport.engine), *this, nullptr};
    DrawableRectangle cursor, pendingCursorTo, pendingCursorAt;
    te::LambdaTimer cursorUpdater;
    std::optional<int> quantisationNumBars;
    std::optional<te::TimePosition> positionToJumpAt;

    static te::TimePosition roundTo(te::TimePosition pos,
                                    const te::TempoSequence& ts,
                                    int quantisationNumBars, double adjustment)
    {
        const auto barsBeats = ts.toBarsAndBeats(pos);
        const auto nearestBar =
            static_cast<int>((barsBeats.getTotalBars() / quantisationNumBars) +
                             adjustment) *
            quantisationNumBars;

        return ts.toTime(te::tempo::BarsAndBeats{nearestBar});
    }

    static te::TimePosition roundToNearest(te::TimePosition pos,
                                           const te::TempoSequence& ts,
                                           int quantisationNumBars)
    {
        return roundTo(pos, ts, quantisationNumBars, 0.5 - 1.0e-10);
    }

    static te::TimePosition roundUp(te::TimePosition pos,
                                    const te::TempoSequence& ts,
                                    int quantisationNumBars)
    {
        return roundTo(pos, ts, quantisationNumBars, 1.0 - 1.0e-10);
    }

    void updateCursorPosition()
    {
        const auto loopLength =
            transport.getLoopRange().getLength().inSeconds();
        const auto proportion =
            juce::exactlyEqual(loopLength, 0.0)
                ? 0.0
                : transport.getPosition().inSeconds() / loopLength;

        auto r = getLocalBounds().toFloat();
        const float x = r.getWidth() * float(proportion);
        cursor.setRectangle(r.withWidth(2.0f).withX(x));

        // Pending cursor
        pendingCursorTo.setVisible(false);
        pendingCursorAt.setVisible(false);

        if(quantisationNumBars)
        {
            if(auto epc = transport.edit.getCurrentPlaybackContext())
            {
                if(auto pendingChange = epc->getPendingPositionChange())
                {
                    {
                        const auto pendingProportion =
                            juce::exactlyEqual(loopLength, 0.0)
                                ? 0.0
                                : pendingChange->inSeconds() / loopLength;
                        const float pendingX =
                            r.getWidth() * float(pendingProportion);
                        pendingCursorTo.setRectangle(
                            r.withWidth(2.0f).withX(pendingX));
                        pendingCursorTo.setVisible(true);
                    }

                    {
                        const auto pendingAtProportion =
                            juce::exactlyEqual(loopLength, 0.0)
                                ? 0.0
                                : positionToJumpAt->inSeconds() / loopLength;
                        const float pendingX =
                            r.getWidth() * float(pendingAtProportion);
                        pendingCursorAt.setRectangle(
                            r.withWidth(2.0f).withX(pendingX));
                        pendingCursorAt.setVisible(true);
                    }
                }
            }
        }
    }
};
