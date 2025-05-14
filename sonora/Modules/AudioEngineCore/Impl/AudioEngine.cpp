/*
 AudioEngine クラスの実装は、Engine フォルダ内の他の cpp
 ファイルに分割して管理している。
 */

#include <AudioEngineCore/AudioEngine.h>

#include "DeviceStateBroadcaster.h"
#include "EngineKernel.h"
#include "LoopPlayheadSynchroniser.h"
#include "ParameterChangeTracker.h"
#include "PluginStateSerializer.h"
#include "SamplerSpecificCommandHandler.h"
#include "Utils/IdMapper.h"

namespace novonotes
{
AudioEngine::AudioEngine(const std::string& engineTypeId,
                         const std::string& displayName, bool isEngineInPlugin)
{
    // DI
    _kernel = std::make_unique<EngineKernel>(engineTypeId, displayName,
                                             isEngineInPlugin);
    _paramTracker = std::make_unique<ParameterChangeTracker>();
    _pluginStateSerializer = std::make_unique<PluginStateSerializer>();
    _deviceBroadcaster =
        std::make_unique<DeviceStateBroadcaster>(*_pluginStateSerializer);
    _pluginTracker = std::make_unique<PluginStateTrackingManager>(
        *_deviceBroadcaster, *_paramTracker);
    _idMapper = std::make_unique<IdMapper>();
    _samplerSpecificCommandHandler =
        std::make_unique<SamplerSpecificCommandHandler>();
    studio = std::make_unique<StudioService>(
        *_kernel, *_paramTracker, *_pluginTracker, *_deviceBroadcaster,
        *_idMapper, *_pluginStateSerializer, *_samplerSpecificCommandHandler);
    arrangement = std::make_unique<ArrangementService>(*_kernel, *_idMapper);
    _playheadSynchroniser =
        std::make_unique<LoopPlayheadSynchroniser>(*_kernel);
    audio = std::make_unique<AudioService>(*_kernel, *_playheadSynchroniser);
    debugUtility = std::make_unique<DebugUtilityService>(*_kernel);
    transport =
        std::make_unique<TransportService>(*_kernel, *_playheadSynchroniser);
}

AudioEngine::~AudioEngine() = default;

std::string AudioEngine::getDisplayName()
{
    return _kernel->getEngine()
        .getPropertyStorage()
        .getApplicationName()
        .toStdString();
}
std::string AudioEngine::getEngineTypeId() { return _kernel->engineTypeId; }
void AudioEngine::resetState() { _kernel->resetState(); }

}  // namespace novonotes
