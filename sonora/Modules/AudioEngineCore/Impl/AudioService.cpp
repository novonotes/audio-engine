

#include <AudioEngineCore/AudioService.h>

#include "EngineKernel.h"
#include "LoopPlayheadSynchroniser.h"

namespace novonotes
{

AudioService::AudioService(EngineKernel& k, LoopPlayheadSynchroniser& s)
    : _kernel(k)
    , _synchroniser(s)
{}

void AudioService::prepareToPlay(double sampleRate, int blockSize)
{
    _kernel.getAudioInterface().prepareToPlay(sampleRate, blockSize);
}
/// Pass audio and midi buffers to the engine
void AudioService::processBlock(juce::AudioBuffer<float>& buffer,
                                juce::MidiBuffer& midiBuffer)
{
    _kernel.getAudioInterface().processBlock(buffer, midiBuffer);
}

bool AudioService::synchronisePlayhead(juce::AudioProcessor& processor)
{
    // Should set isEngineInPlugin of AudioEngine to true.
    assert(_kernel.isEngineInPlugin);
    return _synchroniser.synchronise(processor);
}

}  // namespace novonotes
