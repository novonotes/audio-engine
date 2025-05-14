#pragma once
#include <juce_core/juce_core.h>

#include <string>

namespace novonotes
{

inline std::string generateUniqueId()
{
    // JUCEのUUID生成機能を使用
    return juce::Uuid().toString().toStdString();
}

}  // namespace novonotes