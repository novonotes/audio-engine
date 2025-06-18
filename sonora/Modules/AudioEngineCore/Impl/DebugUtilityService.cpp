#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/DebugUtilityService.h>
#include <AudioEngineCore/Utils/ExecuteAfterDelay.h>

#include "EngineKernel.h"
#include "TracktionUtilities.h"
#include "Utils/IdGenerator.h"

namespace novonotes
{

// Find all .tracktion files in the same folder as the given file
static juce::Array<juce::File> findProjectFilesInSameFolder(
    const juce::File& inputFilePath)
{
    juce::Array<juce::File> tracktionFiles;

    juce::File parentFolder = inputFilePath.getParentDirectory();

    // Check if the parent folder exists
    if(!parentFolder.exists())
    {
        juce::Logger::writeToLog("Parent folder does not exist: " +
                                 parentFolder.getFullPathName());
        return tracktionFiles;
    }

    // Iterate over files in the parent folder
    juce::DirectoryIterator dirIterator(
        parentFolder, false, "*", juce::File::TypesOfFileToFind::findFiles);

    while(dirIterator.next())
    {
        juce::File file = dirIterator.getFile();

        // Check for .tracktion file extension
        if(file.hasFileExtension(".tracktion"))
        {
            tracktionFiles.add(file);
        }
    }

    return tracktionFiles;
}

DebugUtilityService::DebugUtilityService(EngineKernel& k) : _kernel(k) {}

static void addMidiInputToTrack(te::Edit& edit, te::AudioTrack* track)
{
    auto& dm = edit.engine.getDeviceManager();

    if(auto dev = dm.getMidiInDevice(0))
        for(auto instance : edit.getAllInputDevices())
            if(&instance->getInputDevice() == dev.get())
                if(auto destination = instance->setTarget(
                       track->itemID, true, &edit.getUndoManager(), 0))
                    (*destination)->recordEnabled = true;
}

// Play a test tone
void DebugUtilityService::testTone()
{
    static bool isPlayingTestTone = false;
    if(isPlayingTestTone)
    {
        return;
    }

    isPlayingTestTone = true;

    auto& edit = _kernel.getEdit();

    // test tone 再生用の track をセットアップ
    te::EditItemID testToneTrackId;
    {
        auto* newTrack = _kernel.appendTeAudioTrack(false  // routingWithAuxSend
        );

        addMidiInputToTrack(edit, newTrack);

        _kernel.insertInternalPlugin<te::FourOscPlugin>(*newTrack, 0);
        testToneTrackId = newTrack->itemID;
        assert(newTrack->isMuted(true) == false);
    }

    auto& dm = _kernel.getEngine().getDeviceManager();
    auto dev = te::get_or(dm.getMidiInDevices(), 0, {});
    assert(dev != nullptr);
    assert(te::HostedAudioDeviceInterface::isHostedMidiInputDevice(*dev));
    auto& state = dev->keyboardState;

    // Start the note
    // 次のメッセージループまで遅らせないと、MIDI がうまく到達しないっぽい。
    executeAfterDelay([&state]() { state.noteOn(1, 69, 0.5); }, 0);

    // Stop the note after 1 seconds
    executeAfterDelay([&state]() { state.noteOff(1, 69, 0); }, 2000);

    // Mute the track after 1.2 seconds
    executeAfterDelay(
        [this, testToneTrackId]() {
            _kernel.deleteTeTrack(testToneTrackId);
            isPlayingTestTone = false;
        },
        2100);
}

// Load an edit from a file created by Waveform
void DebugUtilityService::loadEditFromFileMadeByWaveform(
    const juce::File& editFile)
{
    throw UnimplementedError();
    //    jassert(editFile.existsAsFile());
    //    auto projectFile = findProjectFilesInSameFolder(editFile)[0];
    //    jassert(projectFile.existsAsFile());
    //
    //    auto tempProject = te::ProjectManager::TempProject{
    //        _kernel.engine.getProjectManager(), projectFile, false};
    //    auto project = tempProject.project;
    //    jassert(project != nullptr);
    //    const auto numProjectItems = project->getNumProjectItems();
    //    jassert(numProjectItems > 0);
    //    auto projectItemId = project->getProjectItemID(0);
    //    const auto vt =
    //        tracktion::loadEditFromFile(_kernel.engine, editFile,
    //        projectItemId);
    //    _kernel.edit = te::Edit::createEdit({_kernel.engine, vt,
    //    projectItemId,
    //                                         te::Edit::forEditing, nullptr,
    //                                         te::Edit::getDefaultNumUndoLevels()});
    //    jassert(_kernel.edit != nullptr);
}

// Save the current edit state to a file
void DebugUtilityService::saveState(const juce::File& dest)
{
    auto parentDirectory = dest.getParentDirectory();

    // Create the parent directory if it doesn't exist
    if(parentDirectory.exists() == false)
    {
        parentDirectory.createDirectory();
    }

    // Check write access for the destination file
    if(dest.hasWriteAccess() == false)
    {
        throw Error{"Write access is not permitted: " +
                    dest.getFullPathName().toStdString()};
    }

    // Check write access for the parent directory
    if(parentDirectory.hasWriteAccess() == false)
    {
        throw Error{"Write access is not permitted: " +
                    parentDirectory.getFullPathName().toStdString()};
    }

    // Perform the save operation
    {
        // Specify `false` to use a human-readable format
        const bool writeQuickBinaryVersion = false;

        // Use `writeToFile` instead of `saveAs` to save the file.
        // `saveAs` cannot be used if the Edit was created with empty juce::File
        // object.
        te::EditFileOperations(_kernel.getEdit())
            .writeToFile(dest, writeQuickBinaryVersion);
    }
}

// Retrieve the current debug state as an XML string
std::string DebugUtilityService::getDebugState()
{
    return _kernel.getEdit().state.toXmlString().toStdString();
}

// Get the internal engine pointer
void* DebugUtilityService::getInternalEngine() { return &_kernel.getEngine(); }

// Get the internal edit pointer
void* DebugUtilityService::getInternalEdit() { return _kernel.getEditOrNull(); }

}  // namespace novonotes
