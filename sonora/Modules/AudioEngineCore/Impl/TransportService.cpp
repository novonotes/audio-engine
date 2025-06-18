

#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/TransportService.h>

#include "EngineKernel.h"
#include "LoopPlayheadSynchroniser.h"
#include "TracktionUtilities.h"

using namespace std::literals;

namespace novonotes
{

TransportService::TransportService(EngineKernel& k, LoopPlayheadSynchroniser& s)
    : _kernel(k)
    , _synchroniser(s)
{}

void TransportService::togglePlay()
{
    EngineHelpers::togglePlay(_kernel.getEdit());
}

void TransportService::startPlay()
{
    _kernel.getEdit().getTransport().play(false);
}

void TransportService::stopPlay()
{
    _kernel.getEdit().getTransport().stop(false, false);
}

void TransportService::setTempo(const double tempo)
{
    _kernel.getEdit().tempoSequence.getTempos()[0]->setBpm(tempo);
}

void TransportService::setPlayheadPosition(const BeatPosition& positionInBeats)
{
    _kernel.getEdit().getTransport().setPosition(
        _kernel.beatToTeTimePosition(positionInBeats));
}

juce::AudioPlayHead::CurrentPositionInfo TransportService::getPlayheadPosition()
{
    return te::getCurrentPositionInfo(_kernel.getEdit());
}

BeatPosition TransportService::getLoopStart()
{
    if(_kernel.isEngineInPlugin)
    {
        return {_synchroniser.getLoopStart()};
    }
    auto& edit = _kernel.getEdit();
    auto loopRangeTime = edit.getTransport().getLoopRange();
    auto loopRangeBeat = edit.tempoSequence.toBeats(loopRangeTime);
    return {loopRangeBeat.getStart().inBeats()};
}

BeatDuration TransportService::getLoopDuration()
{
    if(_kernel.isEngineInPlugin)
    {
        auto loopEnd = _synchroniser.getLoopEnd();
        auto loopStart = _synchroniser.getLoopStart();
        return {loopEnd - loopStart};
    }
    auto& edit = _kernel.getEdit();
    auto loopRangeTime = edit.getTransport().getLoopRange();
    auto loopRangeBeat = edit.tempoSequence.toBeats(loopRangeTime);
    return {loopRangeBeat.getLength().inBeats()};
}

void TransportService::setLoopRange(const BeatPosition& loopStart,
                                    const BeatDuration& loopDuration)
{
    double start = loopStart.numBeats;
    double end = start + loopDuration.numBeats;
    if(_kernel.isEngineInPlugin)
    {
        _synchroniser.setLoopRange(start, end);
        return;
    }
    auto& edit = _kernel.getEdit();
    te::BeatRange loopBeatRange{
        te::BeatPosition::fromBeats(loopStart.numBeats),
        te::BeatDuration::fromBeats(loopDuration.numBeats)};
    te::TimeRange loopTimeRange = edit.tempoSequence.toTime(loopBeatRange);
    edit.getTransport().setLoopRange(loopTimeRange);
    // TODO: enableLoop/disableLoop のメソッドを作るべき。
    edit.getTransport().looping = true;
}

void TransportService::setOffset(const BeatPosition& newOffset)
{
    if(_kernel.isEngineInPlugin == false)
    {
        throw FailedPreconditionError(
            "setOffset can be called only in Engine-in-plugin mode.");
    }
    _synchroniser.setOffset(newOffset.numBeats);
}

void TransportService::enableLoop()
{
    if(_kernel.isEngineInPlugin)
    {
        _synchroniser.enableLoop();
        return;
    }
    _kernel.getEdit().getTransport().looping = true;
}

void TransportService::disableLoop()
{
    if(_kernel.isEngineInPlugin)
    {
        _synchroniser.disableLoop();
        return;
    }

    _kernel.getEdit().getTransport().looping = false;
}

}  // namespace novonotes
