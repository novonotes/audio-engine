#pragma once

#include "ArrangementService.h"
#include "AudioService.h"
#include "DebugUtilityService.h"
#include "StudioService.h"
#include "TransportService.h"

namespace novonotes
{

// AudioEngineCore は AudioEngineCore という公開インターフェースのライブラリと
// AudioEngineCoreImpl という実装のライブラリの二つに分けている。
// 現在、AudioEngineCoreImpl は tracktion_engine に依存しているが、
// 今後書き換える可能性があるので、AudioEngineCore は tracktion engine
// のヘッダーをインクルードできないようにビルドシステムを設定している。

// 前方宣言
class EngineKernel;
class ParameterChangeTracker;
class PluginStateTrackingManager;
class DeviceStateBroadcaster;
class IdMapper;
class PluginStateSerializer;

class AudioEngine
{
   public:
    AudioEngine(const std::string& engineTypeId, const std::string& displayName,
                bool isEngineInPlugin);
    ~AudioEngine();

    std::string getDisplayName();
    std::string getEngineTypeId();

    /// Engine の状態を初期状態へリセット。
    /// 出力オーディオデバイスなどの設定は reset しない。
    /// トラックやデバイスなどの編集状態のみ。
    void resetState();

    StudioService& getStudioService() { return *studio; }
    ArrangementService& getArrangementService() { return *arrangement; }
    AudioService& getAudioService() { return *audio; }
    DebugUtilityService& getDebugUtilityService() { return *debugUtility; }
    TransportService& getTransportService() { return *transport; }

    IdMapper& getIdMapper() { return *_idMapper; }

   private:
    std::unique_ptr<StudioService> studio;
    std::unique_ptr<ArrangementService> arrangement;
    std::unique_ptr<AudioService> audio;
    std::unique_ptr<DebugUtilityService> debugUtility;
    std::unique_ptr<TransportService> transport;

    std::unique_ptr<EngineKernel> _kernel;
    std::unique_ptr<ParameterChangeTracker> _paramTracker;
    std::unique_ptr<PluginStateTrackingManager> _pluginTracker;
    std::unique_ptr<DeviceStateBroadcaster> _deviceBroadcaster;
    std::unique_ptr<IdMapper> _idMapper;
    std::unique_ptr<PluginStateSerializer> _pluginStateSerializer;
    std::unique_ptr<SamplerSpecificCommandHandler>
        _samplerSpecificCommandHandler;
    std::unique_ptr<LoopPlayheadSynchroniser> _playheadSynchroniser;
};
}  // namespace novonotes
