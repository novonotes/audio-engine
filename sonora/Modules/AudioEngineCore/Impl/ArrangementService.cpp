#include <AudioEngineCore/ArrangementService.h>
#include <AudioEngineCore/Common/Errors.h>

#include "EngineKernel.h"
#include "Utils/IdGenerator.h"
#include "Utils/IdMapper.h"

using namespace std::literals;

namespace novonotes
{

ArrangementService::ArrangementService(EngineKernel& k, IdMapper& mapper)
    : _kernel(k)
    , _idMapper(mapper)
{}

AudioTrackId ArrangementService::createAudioTrack(
    const std::optional<AudioTrackId>& id)
{
    // アプリ側のIDを決定（トラック作成前に）
    // ユーザーが指定したIDがあればそれを使用し、なければ新しいIDを生成
    AudioTrackId trackId = id.value_or(AudioTrackId{generateUniqueId()});

    // トラック作成時にIDを渡す
    auto* newTrack = _kernel.appendTeAudioTrack(true);
    _idMapper.mapId(trackId, newTrack->itemID);

    return trackId;
}

void ArrangementService::deleteTrack(AudioTrackId id)
{
    auto teTrackId = _idMapper.getTeId(id);
    auto itemId = teTrackId;

    _kernel.deleteTeTrack(itemId);
    _idMapper.removeMapping(id);
}

AudioRegionId ArrangementService::addAudioRegion(
    AudioTrackId trackId, juce::File sourceFile,
    const BeatPosition& positionInBeats,
    const std::optional<BeatDuration>& durationInBeats,
    const AudioRegionId& appSpecifiedId, bool shouldLoop, float gainDb)
{
    if(sourceFile.existsAsFile() == false)
    {
        throw FileNotFoundError{"The source file not found."};
    }

    auto teTrackId = _idMapper.getTeId(trackId);

    auto* track = _kernel.findTeTrack(teTrackId);

    if(track == nullptr)
    {
        throw NotFoundError{"The specified audio track does not exist."};
    }
    if(auto* audioTrack = dynamic_cast<te::AudioTrack*>(track))
    {
        te::AudioFile audioFile(_kernel.getEngine(), sourceFile);

        auto beatPos = te::BeatPosition::fromBeats(positionInBeats.numBeats);

        // Create clip position
        te::ClipPosition clipPos;

        if(durationInBeats.has_value())
        {
            clipPos = te::createClipPosition(
                _kernel.getEdit().tempoSequence,
                te::BeatRange{beatPos, te::BeatDuration::fromBeats(
                                           durationInBeats.value().numBeats)});
        }
        else
        {
            auto timePos = _kernel.getEdit().tempoSequence.toTime(beatPos);
            clipPos = te::createClipPosition(
                _kernel.getEdit().tempoSequence,
                te::TimeRange{timePos, te::TimeDuration::fromSeconds(
                                           audioFile.getLength())});
        }

        // Insert AudioRegion as te::WaveAudioClip
        if(audioFile.isValid() == false)
        {
            throw Error{"The audio file is not valid."};
        }

        if(auto newClip = audioTrack->insertWaveClip(
               sourceFile.getFileNameWithoutExtension(), sourceFile, clipPos,
               false))
        {
            Logger::writeToLog("ID mapped: " + appSpecifiedId.value);

            _idMapper.mapId(appSpecifiedId, newClip->itemID);

            if(shouldLoop)
            {
                newClip->setLoopRange(te::TimeRange{
                    {}, te::TimeDuration::fromSeconds(audioFile.getLength())});
            }
            newClip->setGainDB(gainDb);
            return {newClip->itemID.toString().toStdString()};
        }
        throw InternalError{"Clip creation failed."};
    }
    throw InternalError{"The track is not an te::AudioTrack."};
}

void ArrangementService::removeAudioRegion(AudioRegionId id)
{
    auto teClipId = _idMapper.getTeId(id);
    te::Clip* clip = _kernel.findTeClip(teClipId);
    clip->removeFromParent();
    _idMapper.removeMapping(id);
}

}  // namespace novonotes
