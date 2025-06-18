#pragma once

#include <juce_core/juce_core.h>

#include <unordered_map>
#include <variant>

#include "Common/Ids.h"
#include "DeviceSpecificCommand.h"

namespace novonotes
{
struct AudioOutputTag
{};

using ConnectionSrc = std::variant<AudioTrackId, MidiTrackId, DeviceInstanceId>;
using ConnectionDest = std::variant<DeviceInstanceId, AudioOutputTag>;

class EngineKernel;
class IdMapper;
class ParameterChangeTracker;
class PluginStateTrackingManager;
class DeviceStateBroadcaster;
class PluginStateSerializer;
class SamplerSpecificCommandHandler;

struct DeviceDescriptor
{
    DeviceTypeId deviceTypeId;
    std::string displayName;
    std::string pluginFormatName;
    /// VST3 の場合は複数のカテゴリーをもちうる。
    std::vector<std::string> categories;
    std::string manufacturerName;
    std::string version;
};

struct NumericParameterDetails
{
    float normalizedCurrentValue;
    float normalizedDefaultValue;
    std::string minValue;
    std::string maxValue;
    int stepCount;
};

struct ChoiceParameterDetails
{
    std::vector<std::string> options;
};

using ParameterDetails =
    std::variant<NumericParameterDetails, ChoiceParameterDetails>;

struct DeviceParameter
{
    ParameterId parameterId;
    std::string displayName;
    std::string textDefaultValue;
    std::string textCurrentValue;
    std::string parameterSyncKey;
    ParameterDetails details;
};

struct DeviceInstance
{
    DeviceInstanceId id;
    DeviceTypeId deviceTypeId;
    std::string serializedState;
    std::vector<DeviceParameter> parameters;
};

/// Device の状態を購読するには、このクラスを継承して、仮想関数を override
/// してください。
///
/// see StudioService::addDeviceStateListener
struct DeviceStateListener
{
    virtual ~DeviceStateListener() {}

    // TODO: 引数で DeviceInstanceId または DeviceInstance
    // 全体を取得できるようにする必要がありそう。
    /** Called when the device state is changed by the plugin or host. */
    virtual void deviceStateChanged(const juce::String& serializedState)
    {
        juce::ignoreUnused(serializedState);
    }
};

class StudioService
{
   public:
    StudioService(EngineKernel&, ParameterChangeTracker&,
                  PluginStateTrackingManager&, DeviceStateBroadcaster&,
                  IdMapper&, PluginStateSerializer&,
                  SamplerSpecificCommandHandler&);
    ~StudioService();

    void connect(const ConnectionSrc& src, const ConnectionDest& dest);
    void disconnect(const ConnectionSrc& src, const ConnectionDest& dest);

    // Device Descriptor operations ---------------------------------
    std::vector<DeviceDescriptor> listDeviceDescriptors();
    // TODO: juce::String ではなく std::string を用いる。
    void scanPlugins(const std::vector<juce::String>& directoryPaths);
    /// 見つからない場合は NotFound エラーを投げる。
    DeviceInstance getDeviceInstance(const DeviceInstanceId&);
    void restoreDeviceInstanceState(const DeviceInstanceId&,
                                    const std::string& serializedState);
    // ---------------------------------------------------------------

    // Device Instance operations ---------------------------------
    /// 返り値は新しい Device Instance の ID
    void createDeviceInstance(const DeviceTypeId&, const DeviceInstanceId&);
    void deleteDeviceInstance(const DeviceInstanceId&);
    void showDeviceWindow(const DeviceInstanceId&, bool alwaysOnTop);
    DeviceSpecificCommandResult executeDeviceSpecificCommand(
        const DeviceInstanceId&, const DeviceSpecificCommand&);
    // ---------------------------------------------------------------

    // Parameter operations ------------------------------------------
    /// 一連の Parameter の値変更操作を開始。
    void beginParameterChange(const DeviceInstanceId&, const ParameterId&);
    /// Parameter の Base Value (CV Modulation 適用前の値) を変更。
    void setParameterBaseValue(const DeviceInstanceId&, const ParameterId&,
                               float newValue);
    /// 一連の Parameter の値変更操作を終了。
    void endParameterChange(const DeviceInstanceId&, const ParameterId&);
    /// Parameter の現在の値を取得。CV Modulation 適用前の値。
    float getParameterUnmodulatedValue(const DeviceInstanceId&,
                                       const ParameterId&);
    /// Parameter の現在の値を取得。CV Modulation 適用後の値。
    float getParameterModulatedValue(const DeviceInstanceId&,
                                     const ParameterId&);
    /// Parameter 値をユーザー向けの人間が読める文字列へ変換
    juce::String parameterValueToString(const DeviceInstanceId&,
                                        const ParameterId&, float val);

    // TODO: juce::String ではなく std::string を用いる。
    /// ユーザーによるキーボード入力などによって得られた文字列を Parameter
    /// 値へ変換
    float stringToParameterValue(const DeviceInstanceId&, const ParameterId&,
                                 const juce::String& stringValue);

    /// Parameter が変更途中かどうか。
    ///
    /// 以下のいずれかの場合 true を返す。それ以外の場合は false。
    /// - このクラスの beginParameterChange 呼び出し後、endParameterChange
    /// 呼び出し前の場合
    /// - Plugin の独自の GUI によって、Parameter が変更されている際中の場合。
    bool isParameterChanging(const DeviceInstanceId&, const ParameterId&);
    // ---------------------------------------------------------------

    void addDeviceStateListener(DeviceStateListener*);
    void removeDeviceStateListener(DeviceStateListener*);

   private:
    EngineKernel& _kernel;
    ParameterChangeTracker& _paramTracker;
    PluginStateTrackingManager& _pluginTracker;
    DeviceStateBroadcaster& _deviceBroadcaster;
    IdMapper& _idMapper;
    PluginStateSerializer& _pluginStateSerializer;
    SamplerSpecificCommandHandler& _samplerSpecificCommandHandler;
};
}  // namespace novonotes
