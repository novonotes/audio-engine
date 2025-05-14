#pragma once

#include <juce_core/juce_core.h>

#include <optional>
#include <string>

#include "Common/Ids.h"
#include "Common/Time.h"
namespace novonotes
{

class EngineKernel;

class IdMapper;

class ArrangementService
{
   public:
    ArrangementService(EngineKernel& kernel, IdMapper& mapper);

    /// 新規トラックの作成
    /// @param id 作成するトラックのID。nulloptの場合は内部で生成する
    AudioTrackId createAudioTrack(
        const std::optional<AudioTrackId>& id = std::nullopt);

    void deleteTrack(AudioTrackId id);

    /// 返り値は新しい AudioRegion の ID
    /// @param duration   nullopt の場合 sourceFile と同じ長さの AudioRegion
    /// を作成する。
    AudioRegionId addAudioRegion(AudioTrackId trackId, juce::File sourceFile,
                                 const BeatPosition& position,
                                 const std::optional<BeatDuration>& duration,
                                 const AudioRegionId& appSpecifiedId,
                                 bool shouldLoop = false, float gainDb = 0);

    void removeAudioRegion(AudioRegionId id);

   private:
    EngineKernel& _kernel;
    IdMapper& _idMapper;
};
}  // namespace novonotes
