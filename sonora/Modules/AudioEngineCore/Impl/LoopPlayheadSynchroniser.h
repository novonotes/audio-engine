#pragma once

#include <juce_core/juce_core.h>
#include <tracktion_engine/tracktion_engine.h>

#include <atomic>

#include "EngineKernel.h"

namespace novonotes
{
/**
    LoopPlayheadSynchroniser は、ホストの再生位置と同期しながら、
    Edit
   内のループ設定（ループ開始・終了、オフセット）に基づく再生位置を生成します。

    　寿命は AudioEngine と同じ。
*/
class LoopPlayheadSynchroniser
{
   public:
    explicit LoopPlayheadSynchroniser(EngineKernel& kernel);

    /**
        ホストの AudioPlayHead から再生位置を取得して、
        Edit の再生位置およびテンポ情報を同期します。
        この関数はリアルタイムスレッド上から呼び出すことを想定しています。

         @returns true if it was able to synchronise, false otherwise.
    */
    bool synchronise(juce::AudioPlayHead& playhead);

    /**
        AudioProcessor 経由でホストの再生位置を同期します。
        この関数はリアルタイムスレッド上から呼び出すことを想定しています。
        @returns true if it was able to synchronise, false otherwise.

    */
    bool synchronise(juce::AudioProcessor& processor);

    /**
        現在の同期情報を取得します。リアルタイムスレッドセーフな実装です。
    */
    juce::AudioPlayHead::CurrentPositionInfo getPositionInfo() const;

    /**
        ループ範囲を設定します。（単位はppq）
        この関数は非リアルタイムスレッドから呼び出すことを想定しています。
    */
    void setLoopRange(double startPPQ, double durationPPQ);
    double getLoopStart() const;
    double getLoopEnd() const;

    /**
        オフセットを設定します。（単位はppq）
        この関数は非リアルタイムスレッドから呼び出すことを想定しています。
    */
    void setOffset(double newOffset);
    double getOffset() const;

    inline void enableLoop() { _loopEnabled = true; }
    inline void disableLoop() { _loopEnabled = false; }

   private:
    double computeMappedPPQ(double hostPPQ) const;

    EngineKernel& _kernel;
    mutable juce::SpinLock _positionInfoLock;
    juce::AudioPlayHead::CurrentPositionInfo _positionInfo;

    // ループ設定およびオフセットは、リアルタイムスレッドからも読み出されるため、atomicで管理します。
    std::atomic<double> _loopStart{0.0};    // ループ開始位置 (ppq)
    std::atomic<double> _loopEnd{0.0};      // ループ終了位置 (ppq)
    std::atomic<double> _offset{0.0};       // オフセット (ppq)
    std::atomic<bool> _loopEnabled{false};  // loop が有効なときに true。
};

}  // namespace novonotes
