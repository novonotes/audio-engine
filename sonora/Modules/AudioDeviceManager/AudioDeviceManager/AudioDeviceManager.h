#pragma once

#include <AudioEngineCore/AudioEngine.h>
#include <juce_audio_basics/juce_audio_basics.h>
#include <juce_audio_devices/juce_audio_devices.h>
#include <juce_core/juce_core.h>

#include <memory>

namespace novonotes
{
struct AudioDeviceManager : public juce::AudioIODeviceCallback
{
    using AudioDeviceSetup = juce::AudioDeviceManager::AudioDeviceSetup;

    AudioDeviceManager(AudioEngine &engine);
    ~AudioDeviceManager() override;

   private:
    juce::AudioDeviceManager::AudioDeviceSetup _setup;
    std::unique_ptr<juce::AudioDeviceManager> _adm;
    juce::AudioSampleBuffer _processBuffer;
    AudioEngine &_engine;

    juce::String loadDefaultDevice(double sampleRate, int blockSize);
    juce::String loadDevice(AudioDeviceSetup const &setup);
    void unloadDevice();
    bool isRunning() const;
    void processBlock(juce::AudioSampleBuffer &buffer);

    virtual void audioDeviceIOCallbackWithContext(
        const float *const *inputChannelData, int numInputChannels,
        float *const *outputChannelData, int numOutputChannels, int numSamples,
        const juce::AudioIODeviceCallbackContext &context) override;

    void audioDeviceAboutToStart(juce::AudioIODevice *device) override;
    void audioDeviceStopped() override;
    void audioDeviceError(const juce::String &errorMessage) override;
};

}  // namespace novonotes
