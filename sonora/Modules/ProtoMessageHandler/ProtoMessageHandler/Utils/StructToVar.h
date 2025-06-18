#pragma once

#include <google/protobuf/struct.pb.h>
#include <juce_core/juce_core.h>

/**
 * @brief Protocol Buffers の Value を juce::var に変換します。
 *
 * @param value 変換元の google::protobuf::Value
 * @return 変換後の juce::var
 */
juce::var convertProtobufValue(const google::protobuf::Value& value);

/**
 * @brief Protocol Buffers の Struct を juce::var (DynamicObject) に変換します。
 *
 * @param protoStruct 変換元の google::protobuf::Struct
 * @return 変換後の juce::var (DynamicObject)
 */
juce::var convertProtobufStruct(const google::protobuf::Struct& protoStruct);
