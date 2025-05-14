#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/StudioService.h>

#include "DeviceStateBroadcaster.h"
#include "EngineKernel.h"
#include "ParameterChangeTracker.h"
#include "PluginStateSerializer.h"
#include "SamplerSpecificCommandHandler.h"
#include "Utils/BuiltInPluginDescriptions.h"
#include "Utils/IdMapper.h"

namespace novonotes
{
StudioService::StudioService(EngineKernel& k, ParameterChangeTracker& p,
                             PluginStateTrackingManager& pst,
                             DeviceStateBroadcaster& dsb, IdMapper& mapper,
                             PluginStateSerializer& codec,
                             SamplerSpecificCommandHandler& s

                             )
    : _kernel(k)
    , _paramTracker(p)
    , _pluginTracker(pst)
    , _deviceBroadcaster(dsb)
    , _idMapper(mapper)
    , _pluginStateSerializer(codec)
    , _samplerSpecificCommandHandler(s)
{}

StudioService::~StudioService() = default;

void StudioService::connect(const ConnectionSrc& src,
                            const ConnectionDest& dest)
{
    te::EditItemID srcEditItemId;
    if(auto* at = std::get_if<AudioTrackId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*at);
    }
    else if(auto* mt = std::get_if<MidiTrackId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*mt);
    }
    else if(auto* di = std::get_if<DeviceInstanceId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*di);
    }
    else
    {
        throw InternalError("Unhandled ConnectionSrc type");
    }

    te::EditItemID destEditItemId;
    if(auto* di = std::get_if<DeviceInstanceId>(&dest))
    {
        destEditItemId = _idMapper.getTeId(*di);
    }
    else if(auto* ao = std::get_if<AudioOutputTag>(&dest))
    {
        destEditItemId = _kernel.getEdit().getMasterTrack()->itemID;
    }
    else
    {
        throw InternalError("Unhandled ConnectionDest type");
    }

    _kernel.connectTeAudioTrackWithAuxSend(srcEditItemId, destEditItemId);
}

void StudioService::disconnect(const ConnectionSrc& src,
                               const ConnectionDest& dest)
{
    // TODO: connect 関数と共通化
    te::EditItemID srcEditItemId;
    if(auto* at = std::get_if<AudioTrackId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*at);
    }
    else if(auto* mt = std::get_if<MidiTrackId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*mt);
    }
    else if(auto* di = std::get_if<DeviceInstanceId>(&src))
    {
        srcEditItemId = _idMapper.getTeId(*di);
    }
    else
    {
        throw InternalError("Unhandled ConnectionSrc type");
    }

    te::EditItemID destEditItemId;
    if(auto* di = std::get_if<DeviceInstanceId>(&dest))
    {
        destEditItemId = _idMapper.getTeId(*di);
    }
    else if(auto* ao = std::get_if<AudioOutputTag>(&dest))
    {
        destEditItemId = _kernel.getEdit().getMasterTrack()->itemID;
    }
    else
    {
        throw InternalError("Unhandled ConnectionDest type");
    }

    _kernel.disconnectTeAudioTrackWithAuxSend(srcEditItemId, destEditItemId);
}
static DeviceDescriptor convertToDeviceDescriptor(
    const juce::PluginDescription& desc)
{
    DeviceDescriptor device;
    device.deviceTypeId = {desc.createIdentifierString().toStdString()};
    device.displayName = desc.name.toStdString();
    device.pluginFormatName = desc.pluginFormatName.toStdString();
    // pluginFormatName が VST3 の場合に category を分割
    if(device.pluginFormatName == "VST3")
    {
        std::string category = desc.category.toStdString();
        std::stringstream ss(category);
        std::string item;
        while(std::getline(ss, item, '|'))
        {
            device.categories.push_back(item);
        }
    }
    else
    {
        device.categories = {desc.category.toStdString()};
    }
    device.manufacturerName = desc.manufacturerName.toStdString();
    device.version = desc.version.toStdString();
    return device;
}

std::vector<DeviceDescriptor> StudioService::listDeviceDescriptors()
{
    std::vector<DeviceDescriptor> deviceDescriptors;

    auto& pm = _kernel.getEngine().getPluginManager();

    auto builtInPluginDescriptions = getSupportedBuiltInPluginDescriptions();
    for(const auto& desc : builtInPluginDescriptions)
    {
        deviceDescriptors.push_back(convertToDeviceDescriptor(desc));
    }

    auto externalPluginDescriptions = pm.knownPluginList.getTypes();
    for(const auto& desc : externalPluginDescriptions)
    {
        deviceDescriptors.push_back(convertToDeviceDescriptor(desc));
    }

    return deviceDescriptors;
}

void StudioService::scanPlugins(const std::vector<juce::String>& directoryPaths)
{
    auto& manager = _kernel.getEngine().getPluginManager();
    auto& knownPluginList = manager.knownPluginList;
    auto& formatManager = manager.pluginFormatManager;

    // directoryPaths をセミコロンで結合
    juce::String joinedPaths;
    for(const auto& path : directoryPaths)
    {
        if(!joinedPaths.isEmpty()) joinedPaths += ";";
        joinedPaths += path;
    }
    // スキャン対象のディレクトリ
    juce::FileSearchPath searchPath{joinedPaths};

    // Dead Man's Pedal ファイルを指定
    juce::File deadMansPedalFile =
        juce::File::getSpecialLocation(juce::File::tempDirectory)
            .getChildFile("dead_mans_pedal_5");

    //    juce::File deadMansPedalFile;

    // VST フォーマットを取得
    if(formatManager.getNumFormats() == 0)
    {
        throw InternalError("No plugin formats available!");
    }
    // 最初のフォーマットを使用
    juce::AudioPluginFormat* format = formatManager.getFormat(0);

    // プラグインスキャナを初期化
    juce::PluginDirectoryScanner scanner(knownPluginList, *format, searchPath,
                                         true,  // サブディレクトリを検索
                                         deadMansPedalFile,
                                         false  // 非同期プラグインを許可しない
    );

    juce::Logger::writeToLog("Plugin scan started.");

    juce::String pluginName;
    while(scanner.scanNextFile(true, pluginName))  // プラグインをスキャン
    {
        if(pluginName != "")
        {
            juce::Logger::writeToLog("Found: " + pluginName);
        }
    }

    juce::Logger::writeToLog("Plugin scan completed.");
}

static bool isChoiceType(te::AutomatableParameter* param)
{
    if(param->getNumberOfStates() == 2)
    {
        return true;
    }
    if(param->getAllLabels().isEmpty() == false)
    {
        return true;
    }
    return false;
}

DeviceInstance StudioService::getDeviceInstance(const DeviceInstanceId& id)
{
    // DeviceInstance を初期化
    DeviceInstance deviceInstance;
    deviceInstance.id = id;

    // デバイスIDを TE Track ID にマッピング
    auto teTrackId = _idMapper.getTeId(id);

    // デバイスに対応するプラグインを取得
    auto* plugin = _kernel.getInternalPluginOfDevice(teTrackId);
    if(plugin == nullptr)
    {
        throw NotFoundError("DeviceInstance not found: " + id.value);
    }

    // DeviceTypeId を設定
    if(auto* externalPlugin = dynamic_cast<te::ExternalPlugin*>(plugin))
    {
        deviceInstance.deviceTypeId =
            DeviceTypeId{externalPlugin->getIdentifierString().toStdString()};
    }
    else
    {
        std::vector<juce::PluginDescription> descriptions =
            getSupportedBuiltInPluginDescriptions();
        for(const auto& desc : descriptions)
        {
            if(desc.fileOrIdentifier == plugin->getPluginType())
            {
                deviceInstance.deviceTypeId =
                    DeviceTypeId{desc.createIdentifierString().toStdString()};
                break;
            }
        }
    }

    // DeviceTypeId が設定されているか検証
    if(deviceInstance.deviceTypeId.value.empty())
    {
        throw InternalError(
            "DeviceTypeId is unexpectedly empty for DeviceInstance: " +
            id.value);
    }

    // プラグインの状態を取得して設定
    plugin->flushPluginStateToValueTree();
    deviceInstance.serializedState = _pluginStateSerializer.serialize(plugin);

    // パラメータ情報を収集して設定
    auto teParameters = plugin->getAutomatableParameters();
    for(auto* teParam : teParameters)
    {
        ParameterId paramId{teParam->paramID.toStdString()};

        std::string parameterSyncKey = id.value + ":" + paramId.value;

        juce::String defaultVal =
            teParam->valueToString(teParam->getDefaultValue().value_or(0.0f));

        juce::String currentVal =
            teParam->valueToString(teParam->getCurrentNormalisedValue());

        ParameterDetails details;

        // チョイス型の場合と数値型の場合で分岐
        if(isChoiceType(teParam))
        {
            ChoiceParameterDetails choiceDetails;
            // teParam の全ラベルを取得して option リストに変換
            auto labels = teParam->getAllLabels();
            for(int i = 0; i < labels.size(); ++i)
            {
                choiceDetails.options.push_back(labels[i].toStdString());
            }
            details = choiceDetails;
        }
        else
        {
            NumericParameterDetails numericDetails;
            numericDetails.normalizedCurrentValue =
                teParam->getCurrentNormalisedValue();
            numericDetails.normalizedDefaultValue =
                teParam->getDefaultValue().value_or(0.0f);
            numericDetails.minValue = teParam->valueToString(0).toStdString();
            numericDetails.maxValue = teParam->valueToString(1).toStdString();
            numericDetails.stepCount = teParam->getNumberOfStates();
            details = numericDetails;
        }

        DeviceParameter parameter{paramId,
                                  teParam->getParameterName().toStdString(),
                                  defaultVal.toStdString(),
                                  currentVal.toStdString(),
                                  parameterSyncKey,
                                  details};

        deviceInstance.parameters.emplace_back(std::move(parameter));
    }

    return deviceInstance;
}

void StudioService::restoreDeviceInstanceState(
    const DeviceInstanceId& deviceId, const std::string& internalStateData)
{
    // デバイスIDをTE Track IDにマッピング
    auto teTrackId = _idMapper.getTeId(deviceId);

    // デバイスに対応するプラグインを取得
    auto* plugin = _kernel.getInternalPluginOfDevice(teTrackId);
    if(plugin == nullptr)
    {
        throw NotFoundError("DeviceInstance not found: " + deviceId.value);
    }
    _pluginStateSerializer.deserialize(internalStateData, plugin);
}

void StudioService::createDeviceInstance(const DeviceTypeId& typeId,
                                         const DeviceInstanceId& instanceId)
{
    // AudioTrack 作成
    auto track = _kernel.appendTeAudioTrack(true);

    te::Plugin::Ptr mainPlugin;

    // pluginList に te::Plugin のインスタンスを挿入。
    // 最終的に pluginList を [AuxReturn, mainPlugin, VolumeAndPan]
    // の形にしたい。 ただし、初めから VolumeAndPan は挿入済み。
    {
        // メインプラグインを先頭へインサート
        mainPlugin = _kernel.insertPlugin(*track, typeId.value, 0);

        // 全 parameter について、ParameterChangeTracker による追跡を有効化。
        {
            // 現在、Plugin 初期化時のみ _paramTracker を追加しているが、
            // ParameterListChangeListener
            // というのを使って実装しないと、動的なパラメーター追加削除に対応できなさそう。

            auto params = mainPlugin->getFlattenedParameterTree();
            for(te::AutomatableParameter* p : params)
            {
                p->addListener(&_paramTracker);
            }
        }

        // AuxReturn を先頭へ挿入
        auto auxReturnPtr =
            _kernel.insertInternalPlugin<te::AuxReturnPlugin>(*track, 0);

        // AuxReturn の busNumber の設定
        if(auto* ar = dynamic_cast<te::AuxReturnPlugin*>(auxReturnPtr.get()))
        {
            ar->busNumber = static_cast<int>(track->itemID.getRawID());
        }
        else
        {
            throw InternalError("Failed to insert AuxReturn plugin.");
        }

        // pluginList は [AuxReturn, mainPlugin, VolumeAndPan]
        // の形になっているはず。
        assert(track->pluginList.size() == 3);
    }

    // トラッキングの開始
    _pluginTracker.startTracking(*mainPlugin);

    // デバイスIDの作成とマッピング
    _idMapper.mapId(instanceId, track->itemID);
}

void StudioService::deleteDeviceInstance(const DeviceInstanceId& deviceId)
{
    // 削除前にトラッキングの停止
    {
        auto teTrackId = _idMapper.getTeId(deviceId);
        auto* mainPlugin = _kernel.getInternalPluginOfDevice(teTrackId);
        _pluginTracker.stopTracking(*mainPlugin);
    }

    // te::AudioTrack を削除
    {
        auto teTrackId = _idMapper.getTeId(deviceId);
        _kernel.deleteTeTrack(teTrackId);
    }

    // マッピングの解除
    _idMapper.removeMapping(deviceId);

    // Edit 全体から、busNumber が itemId になっている AuxSend
    // を探して削除。
    {
        // TODO: Implement
    }
}

void StudioService::showDeviceWindow(const DeviceInstanceId& deviceId,
                                     bool alwaysOnTop)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    te::Plugin* plugin = _kernel.getInternalPluginOfDevice(teTrackId);
    plugin->showWindowExplicitly();
    plugin->windowState->pluginWindow->setAlwaysOnTop(alwaysOnTop);
}

DeviceSpecificCommandResult StudioService::executeDeviceSpecificCommand(
    const DeviceInstanceId& instanceId, const DeviceSpecificCommand& command)
{
    auto teTrackId = _idMapper.getTeId(instanceId);
    te::Plugin* plugin = _kernel.getInternalPluginOfDevice(teTrackId);
    if(auto* sampler = dynamic_cast<te::SamplerPlugin*>(plugin))
    {
        return _samplerSpecificCommandHandler.executeDeviceSpecificCommand(
            *sampler, command);
    }
    // 他の型の plugin のハンドリングを追加。
    throw UnimplementedError(
        "The device does not support device-specific command.");
}

void StudioService::beginParameterChange(const DeviceInstanceId& deviceId,
                                         const ParameterId& parameterId)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    param->beginParameterChangeGesture();
    _paramTracker.parameterChangeGestureBegin(*param);
}
void StudioService::setParameterBaseValue(const DeviceInstanceId& deviceId,
                                          const ParameterId& parameterId,
                                          float newValue)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    param->setParameter(newValue, juce::NotificationType::sendNotification);
}
void StudioService::endParameterChange(const DeviceInstanceId& deviceId,
                                       const ParameterId& parameterId)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    param->endParameterChangeGesture();
    _paramTracker.parameterChangeGestureEnd(*param);
}

float StudioService::getParameterUnmodulatedValue(
    const DeviceInstanceId& deviceId, const ParameterId& parameterId)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    return param->getCurrentBaseValue();
}
float StudioService::getParameterModulatedValue(
    const DeviceInstanceId& deviceId, const ParameterId& parameterId)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    return param->getCurrentValue();
}
juce::String StudioService::parameterValueToString(
    const DeviceInstanceId& deviceId, const ParameterId& parameterId, float val)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    return param->valueToString(val);
}
float StudioService::stringToParameterValue(const DeviceInstanceId& deviceId,
                                            const ParameterId& parameterId,
                                            const juce::String& stringValue)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto param = _kernel.getAutomatableParameter(teTrackId, parameterId.value);
    return param->stringToValue(stringValue);
}
bool StudioService::isParameterChanging(const DeviceInstanceId& deviceId,
                                        const ParameterId& parameterId)
{
    auto teTrackId = _idMapper.getTeId(deviceId);
    auto* plugin = _kernel.getInternalPluginOfDevice(teTrackId);
    return _paramTracker.isChanging(plugin->itemID, parameterId.value);
}

void StudioService::addDeviceStateListener(DeviceStateListener* l)
{
    _deviceBroadcaster.addDeviceStateListener(l);
}
void StudioService::removeDeviceStateListener(DeviceStateListener* l)
{
    _deviceBroadcaster.removeDeviceStateListener(l);
}

}  // namespace novonotes
