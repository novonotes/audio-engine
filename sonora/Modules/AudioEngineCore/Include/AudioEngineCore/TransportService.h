
#pragma once

#include <juce_audio_basics/juce_audio_basics.h>
#include <juce_core/juce_core.h>

#include "Common/Time.h"

namespace novonotes
{

class EngineKernel;
class LoopPlayheadSynchroniser;

class TransportService
{
   public:
    TransportService(EngineKernel& kernel,
                     LoopPlayheadSynchroniser& synchroniser);

    void togglePlay();
    void startPlay();
    void stopPlay();
    void setPlayheadPosition(const BeatPosition& position);
    juce::AudioPlayHead::CurrentPositionInfo getPlayheadPosition();
    void setLoopRange(const BeatPosition& loopStart,
                      const BeatDuration& loopDuration);
    BeatPosition getLoopStart();
    BeatDuration getLoopDuration();
    void setTempo(const double tempo);

    /// EngineInPlugin mode のみ呼び出し可能。
    /// ホストの再生開始から、トランスポートの開始までの時間（Offset）を設定する。
    /// EngineInPlugin mode ではない場合は、PrecondifionFailure の例外を投げる。
    void setOffset(const BeatPosition& value);
    void enableLoop();
    void disableLoop();

   private:
    EngineKernel& _kernel;
    LoopPlayheadSynchroniser& _synchroniser;
};
}  // namespace novonotes
