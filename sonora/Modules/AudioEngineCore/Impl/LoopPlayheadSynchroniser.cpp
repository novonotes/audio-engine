#include "LoopPlayheadSynchroniser.h"

#include <cmath>

namespace novonotes
{

// コンストラクタ: Edit への参照を受け取り、内部情報を初期化する。
LoopPlayheadSynchroniser::LoopPlayheadSynchroniser(EngineKernel& k) : _kernel(k)
{
    _positionInfo.resetToDefault();
    _loopStart.store(0.0);
    _loopEnd.store(0.0);
    _offset.store(0.0);
    _loopEnabled.store(false);
}

//------------------------------------------------------------------------
/**
    ホストの AudioPlayHead から再生位置を取得し、内部の positionInfo
   を更新した上で、 Edit の再生位置およびテンポ等を同期する。
    この関数はリアルタイムスレッドから呼び出すことを想定している。
*/
bool LoopPlayheadSynchroniser::synchronise(juce::AudioPlayHead& playhead)
{
    bool success = false;

    {
        juce::SpinLock::ScopedLockType lock(_positionInfoLock);

        auto pos = playhead.getPosition();
        success = pos.hasValue();
        if(success)
        {
            _positionInfo.resetToDefault();
            if(const auto sig = pos->getTimeSignature())
            {
                _positionInfo.timeSigNumerator = sig->numerator;
                _positionInfo.timeSigDenominator = sig->denominator;
            }
            if(const auto timeInSeconds = pos->getTimeInSeconds())
                _positionInfo.timeInSeconds = *timeInSeconds;
            if(const auto bpm = pos->getBpm()) _positionInfo.bpm = *bpm;

            // ホストの ppqPosition
            // を内部のループ設定とオフセットに基づいてマッピング
            double hostPPQ = 0.0;
            if(pos->getPpqPosition().hasValue())
                hostPPQ = *pos->getPpqPosition();

            double mappedPPQ = computeMappedPPQ(hostPPQ);
            _positionInfo.ppqPosition = mappedPPQ;

            if(const auto lastBarStartPpq = pos->getPpqPositionOfLastBarStart())
                _positionInfo.ppqPositionOfLastBarStart = *lastBarStartPpq;
            if(const auto originTime = pos->getEditOriginTime())
                _positionInfo.editOriginTime = *originTime;
            if(const auto timeInSamples = pos->getTimeInSamples())
                _positionInfo.timeInSamples = *timeInSamples;

            _positionInfo.isPlaying = pos->getIsPlaying();
            _positionInfo.isRecording = pos->getIsRecording();
            _positionInfo.isLooping =
                pos->getIsLooping();  // ホストのループ設定は無視
        }
    }

    if(success)
    {
        auto* edit = _kernel.getEditOrNull();
        if(edit == nullptr)
        {
            return false;
        }
        // ホストの情報に基づいて Edit の位置・テンポ情報を同期
        synchroniseEditPosition(*edit, _positionInfo);
        return true;
    }

    return false;
}

//------------------------------------------------------------------------
/**
    AudioProcessor 経由でホストの再生位置を同期する。
    この関数はリアルタイムスレッドから呼び出すことを想定している。
*/
bool LoopPlayheadSynchroniser::synchronise(juce::AudioProcessor& processor)
{
    if(auto playhead = processor.getPlayHead()) return synchronise(*playhead);
    return false;
}

//------------------------------------------------------------------------
/**
    現在の同期情報を取得する。（リアルタイムスレッドセーフ）
*/
juce::AudioPlayHead::CurrentPositionInfo
LoopPlayheadSynchroniser::getPositionInfo() const
{
    juce::SpinLock::ScopedLockType lock(_positionInfoLock);
    return _positionInfo;
}

//------------------------------------------------------------------------
/**
    ループ範囲を設定する。（単位は ppq）
    この関数は非リアルタイムスレッドから呼び出すことを想定している。
*/
void LoopPlayheadSynchroniser::setLoopRange(double startPPQ, double durationPpq)
{
    double dur = durationPpq > 0 ? durationPpq : 0;
    _loopStart.store(startPPQ, std::memory_order_release);
    _loopEnd.store(startPPQ + dur, std::memory_order_release);
}

double LoopPlayheadSynchroniser::getLoopStart() const
{
    return _loopStart.load(std::memory_order_acquire);
}

double LoopPlayheadSynchroniser::getLoopEnd() const
{
    return _loopEnd.load(std::memory_order_acquire);
}

//------------------------------------------------------------------------
/**
    オフセットを設定する。（単位は ppq）
    この関数は非リアルタイムスレッドから呼び出すことを想定している。
*/
void LoopPlayheadSynchroniser::setOffset(double newOffset)
{
    _offset.store(newOffset, std::memory_order_release);
}

double LoopPlayheadSynchroniser::getOffset() const
{
    return _offset.load(std::memory_order_acquire);
}

//------------------------------------------------------------------------
/**
    ホストの再生位置 (ppq) を、内部のループ設定とオフセットに従って
    Edit 内の再生位置に変換する。
    ・ホストの ppq がオフセット未満の場合は無効な値 (-1.0) を返す。
    ・ホストの ppq からオフセットを引いた値がループ開始未満の場合は 0 を返す。
    ・それ以降は、ループ内の位置として modulus 演算を行いループ内の位置を返す。
*/
double LoopPlayheadSynchroniser::computeMappedPPQ(double hostPPQ) const
{
    // 一度にすべてのatomic変数を読み込んで一貫性を確保する
    const double currentOffset = _offset.load(std::memory_order_acquire);
    const double currentLoopStart = _loopStart.load(std::memory_order_acquire);
    const double currentLoopEnd = _loopEnd.load(std::memory_order_acquire);
    const bool currentLoopEnabled =
        _loopEnabled.load(std::memory_order_acquire);

    // オフセットが設定されていて、ホストの ppq がオフセットに満たない場合は
    // negative な値を返す。
    if(currentOffset > 0.0 && hostPPQ < currentOffset)
        return hostPPQ - currentOffset;

    // オフセットを差し引いた値を候補とする
    double candidate = hostPPQ - currentOffset;

    if(currentLoopEnabled == false) return candidate;

    const double loopLength = currentLoopEnd - currentLoopStart;

    // ループ長がゼロまたは負の場合は、候補値をそのまま返す（ループしない）
    if(loopLength <= 0.0) return candidate;

    // ループ開始より前の場合はそのままの値を返す
    if(candidate < currentLoopStart) return candidate;

    // ループ範囲内に収める：ループ開始からの距離でモジュロ演算する（余りがループ内の位置）
    return currentLoopStart +
           std::fmod((candidate - currentLoopStart), loopLength);
}
}  // namespace novonotes
