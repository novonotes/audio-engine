#pragma once
#include <AudioEngineCore/Common/Ids.h>

namespace novonotes
{
struct ParameterSyncKey
{
    DeviceInstanceId deviceInstanceId;
    ParameterId parameterId;

    // 文字列をパースして ParameterSyncKey オブジェクトを返す。
    // 例: "fx324:cutoff" -> deviceInstanceId = "fx324", parameterId = "cutoff"
    static inline ParameterSyncKey parse(std::string parameterSyncKeyString)
    {
        auto colonPos = parameterSyncKeyString.find(':');
        if(colonPos != std::string::npos)
        {
            DeviceInstanceId deviceId{
                parameterSyncKeyString.substr(0, colonPos)};
            ParameterId paramId{parameterSyncKeyString.substr(colonPos + 1)};
            return {deviceId, paramId};
        }
        throw InvalidArgumentError("Invalid format of parameterSyncKey: " +
                                   parameterSyncKeyString);
    }
};
}  // namespace novonotes
