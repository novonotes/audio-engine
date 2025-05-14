#pragma once
#include <memory>
#include <string>

namespace novonotes
{

struct AppSpecifiedId
{
   public:
    AppSpecifiedId() = default;
    AppSpecifiedId(const AppSpecifiedId&) = default;
    AppSpecifiedId& operator=(const AppSpecifiedId&) = default;
    virtual ~AppSpecifiedId() = default;
    virtual std::string getValue() const = 0;
};

struct AudioRegionId : public AppSpecifiedId
{
    AudioRegionId(const std::string& val) : value(val) {}
    std::string getValue() const override { return value; }
    std::string value;
};

struct AudioTrackId : public AppSpecifiedId
{
    AudioTrackId(const std::string& val) : value(val) {}
    std::string getValue() const override { return value; }
    std::string value;
};

struct MidiTrackId : public AppSpecifiedId
{
    MidiTrackId(const std::string& val) : value(val) {}
    std::string getValue() const override { return value; }
    std::string value;
};

struct DeviceInstanceId : public AppSpecifiedId
{
    DeviceInstanceId(const std::string& val) : value(val) {}
    DeviceInstanceId() = default;
    std::string getValue() const override { return value; }
    std::string value;
};

struct DeviceTypeId
{
    DeviceTypeId(const std::string& val) : value(val) {}
    DeviceTypeId() = default;
    /// juce::PluginDescription::createIdentifierString の返り値
    std::string value;
};

struct ParameterId
{
    ParameterId(const std::string& val) : value(val) {}
    std::string value;
};
}  // namespace novonotes
