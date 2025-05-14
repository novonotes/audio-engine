#pragma once

#include <AudioEngineCore/Common/Errors.h>
#include <AudioEngineCore/Common/Time.h>
#include <juce_core/juce_core.h>
#include <tracktion_engine/tracktion_engine.h>

#include "TracktionUtilities.h"

namespace novonotes
{
/// AudioEngine 内のサービスが共有するモデルやロジックの実装。
class EngineKernel
{
   public:
    EngineKernel(std::string engineTypeId, std::string displayName,
                 bool isEngineInPlugin);

    const bool isEngineInPlugin;
    const std::string engineTypeId;

    te::HostedAudioDeviceInterface& getAudioInterface();
    te::Engine& getEngine();

    /// edit 取得用の関数。edit が存在しない場合、UnavailableError  を投げる。
    te::Edit& getEdit();

    /// リアルタイムスレッド用の edit 取得関数。この関数は Edit
    /// が存在しない場合にも、例外を投げずに nullptr を返す。
    te::Edit* getEditOrNull();

    te::TimePosition beatToTeTimePosition(const BeatPosition& positionInBeats);

    // ==============================================================
    // Track Operations

    /// routingWithAuxSend を true にすると、AuxSend
    /// 以外の方法で別トラックやマスタートラックに音声が流れてしまわないように設定したトラックを返す。
    ///
    /// return される AudioTrack の plugin list は以下のようになる。
    /// [VolumeAndPan]
    ///  VolumeAndPan のパラメーター設定:
    /// routingWithAuxSend == true の場合、volume は -90dB 以下（mute） 。false
    /// の場合 Volume は 0db。
    te::AudioTrack* appendTeAudioTrack(bool routingWithAuxSend = true);
    te::Track* findTeTrack(const te::EditItemID& teTrackId);
    te::Clip* findTeClip(const te::EditItemID& teClipId);

    /// 引数の ID で指定されたトラックを削除。
    /// 指定されたトラックが存在しない場合、NotFound の error を投げる。
    void deleteTeTrack(const te::EditItemID&);

    void connectTeAudioTrackWithAuxSend(const te::EditItemID& srcId,
                                        const te::EditItemID& destId);
    void disconnectTeAudioTrackWithAuxSend(const te::EditItemID& srcId,
                                           const te::EditItemID& destId);

    void resetState();

    /// pluginId で指定されたプラグインを track にインサートする。
    ///
    /// External plugin と Internal plugin 両方に対応。
    ///
    /// 引数 pluginId に渡す値は、
    /// juce::PluginDescription::createIdentifierString の返り値。
    /// 例: "TracktionInternal-Volume and Pan-cfaae71a-0"
    ///
    /// Internal plugin の pluginId が不明な場合、insertInternalPlugin
    /// が使用できる。
    te::Plugin::Ptr insertPlugin(te::AudioTrack& track,
                                 const juce::String& pluginId, int index);

    /// trackId の引数で、Device が用いる te::AudioTrack の ID を指定する。
    te::Plugin* getInternalPluginOfDevice(const te::EditItemID& trackId);

    /// trackId の引数で、Device が用いる te::AudioTrack の ID を指定する。
    te::AutomatableParameter::Ptr getAutomatableParameter(
        const te::EditItemID& trackId, const juce::String& parameterId);

    template <class PluginClass>
    te::Plugin::Ptr insertInternalPlugin(te::AudioTrack& track, int index)
    {
        juce::String xmlTypeName = {PluginClass::xmlTypeName};
        auto pluginPtr =
            _edit->getPluginCache().createNewPlugin(xmlTypeName, {});
        if(!pluginPtr)
            throw NotFoundError("Internal plugin not found: " +
                                xmlTypeName.toStdString());

        track.pluginList.insertPlugin(pluginPtr, index, nullptr);
        return pluginPtr;
    }

   private:
    te::Engine _engine;
    std::unique_ptr<te::Edit> _edit;
    te::SelectionManager _selectionManager;

    void createEmptyEditWithTempFile();
    void setupMidiInputDevices();

    /// 内部プラグインを生成して AudioTrack に挿入する
    /// (例: Reverb, VolumeAndPan, Chorus, Delayなど TE
    /// に組み込まれているプラグイン)
    te::Plugin::Ptr insertInternalPlugin(te::AudioTrack& track,
                                         const juce::String& pluginId,
                                         int index);

    /// 外部プラグイン (VST, 今後 AU 等も含む) を生成して AudioTrack に挿入する
    te::Plugin::Ptr insertExternalPlugin(te::AudioTrack& track,
                                         const juce::String& pluginId,
                                         int index);
};
}  // namespace novonotes
