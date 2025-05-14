#include "AudioDeviceManager.h"
#define _USE_MATH_DEFINES
#include <math.h>

namespace novonotes
{

static std::unique_ptr<juce::AudioDeviceManager> createAudioDeviceManager()
{
    auto p = std::make_unique<juce::AudioDeviceManager>();

    auto deviceType = std::unique_ptr<juce::AudioIODeviceType>{
        juce::AudioIODeviceType::createAudioIODeviceType_CoreAudio()};
    p->addAudioDeviceType(std::move(deviceType));
    p->initialiseWithDefaultDevices(2, 2);

    return p;
}

AudioDeviceManager::AudioDeviceManager(AudioEngine &engine) : _engine(engine)
{
    _adm = createAudioDeviceManager();
    _adm->addAudioCallback(this);

    loadDefaultDevice(44100, 256);
}

AudioDeviceManager::~AudioDeviceManager() { _adm->removeAudioCallback(this); }

void AudioDeviceManager::processBlock(juce::AudioSampleBuffer &buffer)
{
    juce::MidiBuffer midiBuffer{};
    _engine.getAudioService().processBlock(buffer, midiBuffer);
}

juce::String AudioDeviceManager::loadDefaultDevice(double sampleRate,
                                                   int blockSize)
{
    auto dev = _adm->getCurrentDeviceTypeObject();
    AudioDeviceSetup setup;
    setup.sampleRate = sampleRate;
    setup.bufferSize = blockSize;

    auto outputDeviceIndex = dev->getDefaultDeviceIndex(false);
    setup.outputDeviceName = dev->getDeviceNames()[outputDeviceIndex];

    setup.useDefaultInputChannels = true;
    setup.useDefaultOutputChannels = true;

    return _adm->setAudioDeviceSetup(setup, true);
}

juce::String AudioDeviceManager::loadDevice(AudioDeviceSetup const &setup)
{
    if(isRunning())
    {
        return "Device is running.";
    }

    return _adm->setAudioDeviceSetup(setup, true);
}

void AudioDeviceManager::unloadDevice() { _adm->closeAudioDevice(); }

bool AudioDeviceManager::isRunning() const
{
    auto dev = _adm->getCurrentAudioDevice();
    if(!dev)
    {
        return false;
    }

    return dev->isPlaying();
}

void AudioDeviceManager::audioDeviceIOCallbackWithContext(
    const float *const *inputChannelData, int numInputChannels,
    float *const *outputChannelData, int numOutputChannels, int numSamples,
    const juce::AudioIODeviceCallbackContext &context)
{
    juce::ignoreUnused(context);
    if(numSamples > _processBuffer.getNumSamples())
    {
        _processBuffer.setSize(_processBuffer.getNumChannels(), numSamples);
    }

    _processBuffer.clear();

    auto tmpBuffer =
        juce::AudioSampleBuffer(_processBuffer.getArrayOfWritePointers(),
                                _processBuffer.getNumChannels(), numSamples);

    for(auto ch = 0, end = numInputChannels; ch < end; ++ch)
    {
        juce::FloatVectorOperations::copy(tmpBuffer.getWritePointer(ch),
                                          inputChannelData[ch], numSamples);
    }

    processBlock(tmpBuffer);

    for(auto ch = 0, end = numOutputChannels; ch < end; ++ch)
    {
        juce::FloatVectorOperations::copy(
            outputChannelData[ch], tmpBuffer.getReadPointer(ch), numSamples);
    }
}

void AudioDeviceManager::audioDeviceAboutToStart(juce::AudioIODevice *device)
{
    juce::Logger::writeToLog("AudioDevice about to start: " +
                             device->getName());
    auto numInputs = device->getActiveInputChannels().countNumberOfSetBits();
    auto numOutputs = device->getActiveOutputChannels().countNumberOfSetBits();

    _processBuffer.setSize(std::max<int>(numInputs, numOutputs),
                           device->getDefaultBufferSize());

    _engine.getAudioService().prepareToPlay(
        device->getCurrentSampleRate(), device->getCurrentBufferSizeSamples());
}

void AudioDeviceManager::audioDeviceStopped()
{
    juce::Logger::writeToLog("AudioDevice stopped.");
}

void AudioDeviceManager::audioDeviceError(const juce::String &errorMessage)
{
    juce::Logger::writeToLog("AudioDevice error: " + errorMessage);
}
}  // namespace novonotes
