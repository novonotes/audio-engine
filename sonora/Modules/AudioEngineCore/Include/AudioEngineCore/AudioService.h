#pragma once

#include <juce_audio_basics/juce_audio_basics.h>
#include <juce_audio_processors/juce_audio_processors.h>
#include <juce_core/juce_core.h>

namespace novonotes
{

class EngineKernel;
class LoopPlayheadSynchroniser;

/*
 Audio Service

 クライアントとして AudioProcessor や AudioDeviceManager などを想定した Service
 */
class AudioService
{
   public:
    AudioService(EngineKernel& kernel, LoopPlayheadSynchroniser& synchroniser);

    /// Call each time the sample rate or block size changes
    void prepareToPlay(double sampleRate, int blockSize);

    /// Pass audio and midi buffers to the engine
    void processBlock(juce::AudioBuffer<float>& buffer,
                      juce::MidiBuffer& midiBuffer);

    /**
      EngineInPlugin モードの場合のみ、呼び出すべき。
     Synchronises the Edit's playback position with the AudioProcessor's
       playhead if possible. Generally you'd call this at the start of your
       plugin's processBlock method.
        @returns true if it was able to synchronise, false otherwise.
    */
    bool synchronisePlayhead(juce::AudioProcessor& processor);

   private:
    EngineKernel& _kernel;
    LoopPlayheadSynchroniser& _synchroniser;
};
}  // namespace novonotes
