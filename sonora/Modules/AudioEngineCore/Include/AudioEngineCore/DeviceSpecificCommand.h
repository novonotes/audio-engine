class DeviceSpecificCommand
{};
class DeviceSpecificCommandResult
{};

// Sampler 固有コマンド
class AddSoundCommand : public DeviceSpecificCommand
{};

class AddSoundCommandResult : public DeviceSpecificCommandResult
{};

class RemoveSoundCommand : public DeviceSpecificCommand
{};

class RemoveSoundCommandResult : public DeviceSpecificCommandResult
{};
