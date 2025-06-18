#pragma once

namespace StatusCodes
{
constexpr int SUCCESS = 0;
constexpr int UNKNOWN_ERROR = -1;
// Engine が未初期化
constexpr int ENGINE_NOT_INITIALIZED = -2;
constexpr int INVALID_MESSAGE_FORMAT = -3;
constexpr int TIMEOUT_WAITING_FOR_MESSAGE_LOOP = -5;
constexpr int MESSAGE_PROCESSING = -6;
constexpr int ASYNC_CALL_FAILED = -7;
constexpr int DISPATCH_MESSAGE_FAILED = -8;
// Engine が未初期化またはシャットダウン中
constexpr int ENGINE_NOT_RUNNING = -9;
constexpr int MESSAGE_MANAGER_NOT_EXIST = -10;
constexpr int MESSAGE_MANAGER_ALREADY_CREATED = -11;
constexpr int UNSUPPORTED_API_VERSION = -12;
constexpr int ENGINE_ALREADY_INITIALIZED = -13;
constexpr int MESSAGE_MANAGER_ALREADY_INITIALIZED = -14;
constexpr int DART_API_NOT_INITIALIZED = -15;
constexpr int MESSAGE_MANAGER_NOT_INITIALIZED = -16;
constexpr int ENGINE_ALREADY_SHUT_DOWN = -17;
constexpr int ENGINE_NOT_SHUT_DOWN = -18;
constexpr int MESSAGE_MANAGER_NOT_SHUT_DOWN = -19;
constexpr int DART_API_ALREADY_INITIALIZED = -20;
constexpr int MESSAGE_MANAGER_ALREADY_SHUT_DOWN = -21;
constexpr int DART_API_ALREADY_SHUT_DOWN = -22;
constexpr int UDP_CHANNEL_FAILED_TO_START = -23;
}  // namespace StatusCodes
