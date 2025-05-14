#include <AudioEngineCore/Common/Errors.h>

namespace novonotes
{
class SamplerSpecificCommandHandler
{
   public:
    DeviceSpecificCommandResult executeDeviceSpecificCommand(
        te::SamplerPlugin&, const DeviceSpecificCommand&)
    {
        throw UnimplementedError(
            "Sampler-specific command is not implemented yet.");
    }
};
}  // namespace novonotes
