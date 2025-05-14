#pragma once

#include <juce_core/juce_core.h>
#include <tracktion_engine/tracktion_engine.h>

namespace novonotes
{
class PluginStateSerializer
{
   public:
    inline std::string serialize(const te::Plugin* plugin)
    {
        juce::ValueTree vt = plugin->state.createCopy();

        // id のプロパティは復元時に変更されうる仕様なので不要。
        // このプロパティがあると、新規プラグインへの deserialize 直後の
        // serialize で deserialize
        // 前のデータと異なる値が生成されてしまうため削除しておく。
        vt.removeProperty(te::IDs::id, nullptr);

        if(auto* externalPlugin =
               dynamic_cast<const te::ExternalPlugin*>(plugin))
        {
            juce::String stateString = vt.getProperty(te::IDs::state);
            return stateString.toStdString();
        }

#ifdef DEBUG_SERIALIZATION_MODE
        // デバッグモード: 可読性のある XML 形式でシリアライズ
        std::unique_ptr<juce::XmlElement> xml(vt.createXml());
        if(xml != nullptr)
        {
            juce::XmlElement::TextFormat format{};
            juce::String xmlString = xml->toString(format.singleLine());
            return xmlString.toStdString();
        }
        return {};
#else
        // 通常モード: ValueTree をバイナリにシリアライズし、Base64
        // 文字列に変換する
        juce::MemoryOutputStream mos;
        vt.writeToStream(mos);
        juce::String encoded = juce::Base64::toBase64(
            mos.getData(), static_cast<size_t>(mos.getDataSize()));
        return encoded.toStdString();
#endif
    }

    inline void deserialize(std::string serializedState, te::Plugin* plugin)
    {
        if(auto* externalPlugin = dynamic_cast<te::ExternalPlugin*>(plugin))
        {
            plugin->flushPluginStateToValueTree();
            juce::ValueTree vt = plugin->state;
            vt.setProperty(te::IDs::state, {serializedState}, nullptr);
            plugin->restorePluginStateFromValueTree(vt);
            return;
        }

#ifdef DEBUG_SERIALIZATION_MODE
        // デバッグモード: XML 文字列から ValueTree を復元する
        std::unique_ptr<juce::XmlElement> xml(
            juce::XmlDocument::parse(juce::String(serializedState)));
        if(xml != nullptr)
        {
            juce::ValueTree restoredVt = juce::ValueTree::fromXml(*xml);
            if(restoredVt.isValid())
            {
                plugin->restorePluginStateFromValueTree(restoredVt);
            }
        }
#else
        // 通常モード: Base64 文字列をデコードして、バイナリから ValueTree
        // を復元する
        juce::MemoryOutputStream binaryOutput;
        if(juce::Base64::convertFromBase64(binaryOutput,
                                           juce::String(serializedState)))
        {
            juce::MemoryInputStream mis(binaryOutput.getData(),
                                        binaryOutput.getDataSize(), false);
            juce::ValueTree restoredVt = juce::ValueTree::readFromStream(mis);
            plugin->restorePluginStateFromValueTree(restoredVt);
        }
#endif
    }
};
}  // namespace novonotes
