#pragma once

#include <AudioEngineCore/Utils/Logger.h>
#include <juce_core/juce_core.h>
#include <tracktion_engine/tracktion_engine.h>

#include "EngineKernel.h"

namespace novonotes
{

/// ParameterChangeGesture の Begin/end のイベントを監視する。
/// isChanging などの、問い合わせのメソッド呼び出しの際に、 現在 Parameter
/// が変更途中かどうかを返す。
///  AudioEngine　と寿命同じにするべき。
class ParameterChangeTracker : public te::AutomatableParameter::Listener
{
   public:
    explicit ParameterChangeTracker() {}

    void curveHasChanged(te::AutomatableParameter&) override {}

    void parameterChangeGestureBegin(te::AutomatableParameter& param) override
    {
        te::EditItemID pluginId = param.getOwnerID();
        assert(pluginId.toString() != "");
        // 同じパラメータが既に登録されているかチェックして、重複登録を防ぎます。
        if(!containsParameter(pluginId, param.paramID))
        {
            _changingParameterLocators.emplace_back(
                ParameterLocator{pluginId, param.paramID});
        }
    }

    void parameterChangeGestureEnd(te::AutomatableParameter& param) override
    {
        te::EditItemID pluginId = param.getOwnerID();

        auto it = std::remove_if(
            _changingParameterLocators.begin(),
            _changingParameterLocators.end(),
            [&pluginId, &param](const ParameterLocator& locator) {
                return locator.pluginId == pluginId &&
                       locator.paramId == param.paramID;
            });

        if(it != _changingParameterLocators.end())
        {
            _changingParameterLocators.erase(it,
                                             _changingParameterLocators.end());
        }
        else
        {
            Logger::info(
                "parameterChangeGestureEnd: tracked locator "
                "にパラメータまたはプラグインが見つかりません");
        }
    }

    bool isChanging(te::EditItemID pluginId, juce::String paramId)
    {
        return containsParameter(pluginId, paramId);
    }

    bool isAnyParameterChanging(const te::EditItemID& pluginId)
    {
        return std::any_of(_changingParameterLocators.begin(),
                           _changingParameterLocators.end(),
                           [&pluginId](const ParameterLocator& locator) {
                               return locator.pluginId == pluginId;
                           });
    }

   private:
    /// 指定されたプラグインIDとパラメータIDの組み合わせが
    /// すでに変更中のリストに含まれているか確認します。
    bool containsParameter(const te::EditItemID& pluginId,
                           const juce::String& paramId) const
    {
        return std::any_of(
            _changingParameterLocators.begin(),
            _changingParameterLocators.end(),
            [&pluginId, &paramId](const ParameterLocator& locator) {
                return locator.pluginId == pluginId &&
                       locator.paramId == paramId;
            });
    }

    /// プラグインID とパラメータID
    /// の組み合わせで一意のパラメータを特定するための構造体です。
    struct ParameterLocator
    {
        te::EditItemID pluginId;
        juce::String paramId;
    };
    std::vector<ParameterLocator>
        _changingParameterLocators;  ///< 変更中のパラメータを保持するリスト
};
}  // namespace novonotes
