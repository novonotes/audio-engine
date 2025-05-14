#include "EngineKernel.h"

#include <tracktion_engine/tracktion_engine.h>

#include "PluginWindow.h"
#include "TracktionUtilities.h"
#include "Utils/BuiltInPluginDescriptions.h"

namespace novonotes
{

class PluginEngineBehaviour : public te::EngineBehaviour
{
   public:
    bool autoInitialiseDeviceManager() override { return false; }
    bool addSystemAudioIODeviceTypes() override { return false; }
};

EngineKernel::EngineKernel(std::string typeId, std::string appName,
                           bool inPlugin)
    : _engine({appName}, std::make_unique<ExtendedUIBehaviour>(),
              inPlugin ? std::make_unique<PluginEngineBehaviour>() : nullptr)
    , engineTypeId(typeId)
    , isEngineInPlugin(inPlugin)
    , _selectionManager(_engine)
{
    resetState();
}

void EngineKernel::resetState()
{
    JUCE_ASSERT_MESSAGE_THREAD

    createEmptyEditWithTempFile();

    // createEmptyEdit よりも先に呼び出すと、EngineInPlugin モードの際に、test
    // tone が鳴らなくなる。 詳細な原因は不明。 Refactor
    // の際には呼び出し順序に注意すること。
    getAudioInterface().initialise({});

    setupMidiInputDevices();

    _edit->playInStopEnabled = true;

    // Allocate transport context
    _edit->getTransport().ensureContextAllocated(true);
}

te::HostedAudioDeviceInterface& EngineKernel::getAudioInterface()
{
    return _engine.getDeviceManager().getHostedAudioDeviceInterface();
}
te::Engine& EngineKernel::getEngine() { return _engine; }
te::Edit& EngineKernel::getEdit()
{
    if(!_edit)
    {
        // 基本的には常に存在するはずなので　Temporary Unavailable を投げる。
        throw UnavailableError();
    }
    return *_edit;
}

te::Edit* EngineKernel::getEditOrNull() { return _edit.get(); }

te::TimePosition EngineKernel::beatToTeTimePosition(const BeatPosition& pos)
{
    auto bp = te::BeatPosition::fromBeats(pos.numBeats);
    return _edit->tempoSequence.toTime(bp);
}

te::Track* EngineKernel::findTeTrack(const te::EditItemID& teTrackId)
{
    return te::findTrackForID(*_edit, teTrackId);
}
te::Clip* EngineKernel::findTeClip(const te::EditItemID& teClipId)
{
    return te::findClipForID(*_edit, teClipId);
}

te::AudioTrack* EngineKernel::appendTeAudioTrack(bool routingWithAuxSend)
{
    auto tracks = te::getTopLevelTracks(*_edit);
    auto insertPoint = te::TrackInsertPoint{nullptr, tracks[tracks.size() - 1]};
    auto newTrack = _edit->insertNewAudioTrack(insertPoint, &_selectionManager);

    auto& pluginList = newTrack->pluginList;

    // te は、AudioTrack 初期化時に末尾に LevelMeterPlugin
    // がインサートされる仕様っぽい。 GUI 機能はいらないので、削除。
    {
        auto* plugin = pluginList[pluginList.size() - 1];
        if(auto* levelMeter = dynamic_cast<te::LevelMeterPlugin*>(plugin))
        {
            plugin->deleteFromParent();
        }
        else
        {
            DBG(pluginList.state.toXmlString());
            // tracktion engine の仕様が変わった場合、この assert
            // に引っかかるかも。
            assert(false);
        }
    }

    // AuxSend
    // をつかって別トラックへルーティングする場合は、出力音をミュートする。
    if(routingWithAuxSend)
    {
        // AudioTrack::setMute(true) すると、EngineBehaivior の設定次第で AUX
        // が動作しなくなることがあるので、 VolumeAndPanPlugin でミュートする。
        if(auto* volumeAndPanPlugin =
               dynamic_cast<te::VolumeAndPanPlugin*>(pluginList[0]))
        {
            // -90dB以下でミュートになる仕様っぽい
            volumeAndPanPlugin->setVolumeDb(-100.0f);
        }
        else
        {
            throw Error("The first plugin is not VolumeAndPanPlugin");
        }
        jassert(newTrack->isMuted(true) == false);
    }

    return newTrack;
}

void EngineKernel::deleteTeTrack(const te::EditItemID& id)
{
    auto* track = findTeTrack(id);
    if(track == nullptr)
    {
        throw NotFoundError{"The specified track does not exist."};
    }
    _edit->deleteTrack(track);
}

void EngineKernel::connectTeAudioTrackWithAuxSend(const te::EditItemID& srcId,
                                                  const te::EditItemID& destId)
{
    auto* srcTrack = te::findTrackForID(*_edit, srcId);
    auto* destTrack = te::findTrackForID(*_edit, destId);
    if(srcTrack == nullptr)
    {
        throw NotFoundError{"te::AudioTrack Not Found: " +
                            srcId.toString().toStdString()};
    }
    if(destTrack == nullptr)
    {
        throw NotFoundError{"te::AudioTrack Not Found: " +
                            destId.toString().toStdString()};
    }
    if(auto* srcAudioTrack = dynamic_cast<te::AudioTrack*>(srcTrack))
    {
        // destTrack の ID と同じ busNumber を用いた AuxSendPlugin を
        // srcTrack に insert
        auto plugin = _edit->getPluginCache().createNewPlugin(
            te::AuxSendPlugin::xmlTypeName, {});
        auto auxSendPlugin = static_cast<te::AuxSendPlugin*>(plugin.get());
        auxSendPlugin->busNumber =
            static_cast<int>(destTrack->itemID.getRawID());

        auto& pluginList = srcAudioTrack->pluginList;
        // 最少でも VolumeAndPan がインサートされているはず。
        jassert(pluginList.size() >= 1);
        // Volume and Pan の一つ手前に挿入
        auto index = pluginList.size() - 1;
        pluginList.insertPlugin(plugin, index, nullptr);

        return;
    }
    throw Error{};
}
void EngineKernel::disconnectTeAudioTrackWithAuxSend(
    const te::EditItemID& srcId, const te::EditItemID& destId)
{
    auto* srcTrack = te::findTrackForID(*_edit, srcId);
    auto* destTrack = te::findTrackForID(*_edit, destId);
    if(srcTrack == nullptr)
    {
        throw NotFoundError{"te::AudioTrack Not Found: " +
                            srcId.toString().toStdString()};
    }
    if(destTrack == nullptr)
    {
        throw NotFoundError{"te::AudioTrack Not Found: " +
                            destId.toString().toStdString()};
    }
    if(auto* srcAudioTrack = dynamic_cast<te::AudioTrack*>(srcTrack))
    {
        // pluginList をイテレートして、destTrack に信号を送っている
        // auxSendPlugin を探す。 見つかったら一旦 vector に入れる。
        std::vector<te::AuxSendPlugin*> pluginsToDelete;
        for(auto* plugin : srcAudioTrack->pluginList)
        {
            if(auto* auxSendPlugin = dynamic_cast<te::AuxSendPlugin*>(plugin))
            {
                if(auxSendPlugin->busNumber.get() ==
                   static_cast<int>(destTrack->itemID.getRawID()))
                {
                    pluginsToDelete.emplace_back(auxSendPlugin);
                }
            }
        }
        // 見つかったプラグインの delete 処理。
        for(auto* pluginToDelete : pluginsToDelete)
        {
            pluginToDelete->deleteFromParent();
        }
    }
}

void EngineKernel::createEmptyEditWithTempFile()
{
    // TODO createSingleTrackEdit に移行した方がいいかも
    // 第二引数に空ファイルを指定することで、インメモリモードで動作するっぽい？
    // ファイルを指定すると、複数のエンジンインスタンスが並列に動作する場合に
    // コンフリクトが起きそうなので空のファイルオブジェクトを渡しておく。
    _edit = te::createEmptyEdit(_engine, {});

    auto masterTrack = _edit->getMasterTrack();

    // 他の Track からの入力を受け取るための AuxReturnPlugin を Insert
    auto plugin = _edit->getPluginCache().createNewPlugin(
        te::AuxReturnPlugin::xmlTypeName, {});
    auto auxReturnPlugin = static_cast<te::AuxReturnPlugin*>(plugin.get());
    auxReturnPlugin->busNumber =
        static_cast<int>(masterTrack->itemID.getRawID());
    masterTrack->pluginList.insertPlugin(plugin, 0, nullptr);
}

void EngineKernel::setupMidiInputDevices()
{
    auto& dm = _edit->engine.getDeviceManager();

    // Enable all MIDI input devices
    for(auto& midiIn : dm.getMidiInDevices())
    {
        midiIn->setMonitorMode(te::InputDevice::MonitorMode::automatic);
        midiIn->setEnabled(true);
        midiIn->recordingEnabled = true;
    }
}

te::Plugin::Ptr EngineKernel::insertPlugin(te::AudioTrack& track,
                                           const juce::String& pluginId,
                                           int index)
{
    if(pluginId.startsWith("VST"))
    {
        return insertExternalPlugin(track, pluginId, index);
    }
    else
    {
        return insertInternalPlugin(track, pluginId, index);
    }
}

te::Plugin::Ptr EngineKernel::insertExternalPlugin(te::AudioTrack& track,
                                                   const juce::String& pluginId,
                                                   int index)
{
    auto& manager = _engine.getPluginManager();
    auto& knownPluginList = manager.knownPluginList;

    // PluginDescription を取得
    auto descPtr = knownPluginList.getTypeForIdentifierString(pluginId);
    if(!descPtr)
        throw NotFoundError("Plugin not found: " + pluginId.toStdString());

    // ExternalPlugin を生成
    auto pluginPtr = _edit->getPluginCache().createNewPlugin(
        te::ExternalPlugin::xmlTypeName, *descPtr);

    if(!pluginPtr)
        throw InternalError("Failed to create external plugin: " +
                            pluginId.toStdString());

    // トラックにプラグインを挿入
    track.pluginList.insertPlugin(pluginPtr, index, nullptr);

    return pluginPtr;
}

te::Plugin::Ptr EngineKernel::insertInternalPlugin(te::AudioTrack& track,
                                                   const juce::String& pluginId,
                                                   int index)
{
    auto xmlTypeName = convertToXmlTypeName(pluginId);
    if(xmlTypeName == "")
        throw NotFoundError("Internal plugin not found: " +
                            pluginId.toStdString());
    auto pluginPtr = _edit->getPluginCache().createNewPlugin(xmlTypeName, {});
    if(!pluginPtr)
        throw InternalError("Failed to create internal plugin: " +
                            pluginId.toStdString());

    track.pluginList.insertPlugin(pluginPtr, index, nullptr);
    return pluginPtr;
}
te::AutomatableParameter::Ptr EngineKernel::getAutomatableParameter(
    const te::EditItemID& trackId, const juce::String& parameterId)
{
    auto* plugin = getInternalPluginOfDevice(trackId);
    auto param = plugin->getAutomatableParameterByID(parameterId);
    if(param == nullptr)
    {
        throw NotFoundError("Parameter Not Found: " +
                            parameterId.toStdString());
    }
    return param;
}
te::Plugin* EngineKernel::getInternalPluginOfDevice(
    const te::EditItemID& trackId)
{
    auto* track = findTeTrack(trackId);

    // プラグインリストは以下のようになっているはず。
    // [AuxReturn, DeviceのPlugin, AuxSend, AuxSend, ..., AuxSend, VolumeAndPan]
    const int devicePluginIndex = 1;
    auto* plugin = track->pluginList[devicePluginIndex];
    return plugin;
}
}  // namespace novonotes
