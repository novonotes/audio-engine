#pragma once

#include <AudioEngineCore/StudioService.h>
#include <AudioEngineCore/Utils/CallbackTimer.h>
#include <AudioEngineCore/Utils/Logger.h>
#include <juce_core/juce_core.h>
#include <tracktion_engine/tracktion_engine.h>

#include <unordered_map>

#include "ParameterChangeTracker.h"
#include "PluginStateSerializer.h"

namespace te = tracktion;

namespace novonotes
{
// AudioEngine と寿命同じにすべき。
class DeviceStateBroadcaster
{
   public:
    DeviceStateBroadcaster(PluginStateSerializer& p) : _pluginStateSerializer(p)
    {}
    void pluginStateChanged(const te::Plugin& p)
    {
        auto serializedState = _pluginStateSerializer.serialize(&p);
        if(serializedState == "")
        {
            // ここに引っかかる場合、もしかしたら PluginStateSerializer
            // の実装に問題があるのかも。
            assert(false);
            return;
        }
        _listeners.call([&serializedState](DeviceStateListener& l) {
            l.deviceStateChanged(serializedState);
        });
    }
    void addDeviceStateListener(DeviceStateListener* l) { _listeners.add(l); }
    void removeDeviceStateListener(DeviceStateListener* l)
    {
        _listeners.remove(l);
    }

   private:
    juce::ListenerList<DeviceStateListener> _listeners;
    PluginStateSerializer& _pluginStateSerializer;
};

// AudioEngine と寿命同じにすべき。
class PluginStateTrackingManager
{
   public:
    explicit PluginStateTrackingManager(DeviceStateBroadcaster& broadcaster,
                                        ParameterChangeTracker& paramChange)
        : _broadcaster(broadcaster)
        , _paramChange(paramChange)
    {
        // 1秒に一回 state を ValueTree に flush する。
        // この flush によって ValueTree に変更が生じた場合、PluginStateTracker
        // の valueTreeChanged が呼ばれるはず。 ただし、drag
        // などによる、連続的な parameter 変更の途中の場合は flush を skip
        // する。
        {
            _timer.callback = [this](CallbackTimer&) {
                for(const auto& [plugin, tracker] : _pluginTrackers)
                {
                    if(plugin == nullptr)
                    {
                        return;
                    }
                    bool isParameterChanging =
                        _paramChange.isAnyParameterChanging(plugin->itemID);
                    if(isParameterChanging)
                    {
                        // Parameter 変更中は flush を skip
                        // して、変更終了まで待つ。
                        return;
                    }

                    plugin->flushPluginStateToValueTree();
                }
            };
            _timer.startTimerHz(1);
        }
    }

    void startTracking(te::Plugin& internalPlugin)
    {
        auto tracker =
            std::make_unique<PluginStateTracker>(internalPlugin, _broadcaster);
        _pluginTrackers[&internalPlugin] = std::move(tracker);
    }

    /// トラッキング中の te::Plugin
    /// のインスタンス削除前にこのメソッドを呼び出し、トラッキングを停止するべき。
    void stopTracking(te::Plugin& internalPlugin)
    {
        auto it = _pluginTrackers.find(&internalPlugin);
        if(it != _pluginTrackers.end())
        {
            _pluginTrackers.erase(it);
        }
    }

   private:
    /// te::Plugin と寿命同じにすべき。
    /// te::Pluginの削除直前にこのインスタンスを破棄して、Listener
    /// を取り除くべき。
    class PluginStateTracker : public te::ValueTreeAllEventListener
    {
       public:
        PluginStateTracker(te::Plugin& p, DeviceStateBroadcaster& b)
            : _plugin(p)
            , _broadcaster(b)
        {
            _plugin.state.addListener(this);
        }

        ~PluginStateTracker() override { _plugin.state.removeListener(this); }

        void valueTreeChanged() override
        {
            _broadcaster.pluginStateChanged(_plugin);
        }

       private:
        te::Plugin& _plugin;
        DeviceStateBroadcaster& _broadcaster;
    };

    DeviceStateBroadcaster& _broadcaster;
    ParameterChangeTracker& _paramChange;
    std::unordered_map<te::Plugin*, std::unique_ptr<PluginStateTracker>>
        _pluginTrackers;
    CallbackTimer _timer;
};
}  // namespace novonotes
