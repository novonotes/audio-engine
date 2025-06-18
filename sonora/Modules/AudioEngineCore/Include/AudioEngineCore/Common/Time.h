#pragma once

#include <cstdint>

namespace novonotes
{

// 時間軸上の位置を拍の単位で表す
struct BeatPosition
{
    double numBeats;
};

// 時間軸上の長さを拍の単位で表す
struct BeatDuration
{
    double numBeats;
};

struct TimePosition
{
    double seconds;
};

struct TimeDuration
{
    double seconds;
};

}  // namespace novonotes
