// ignore_for_file: constant_identifier_names

class StatusCodes {
  static const int SUCCESS = 0;
  static const int UNKNOWN_ERROR = -1;
  static const int ENGINE_NOT_INITIALIZED = -2; // Engine が未初期化
  static const int INVALID_MESSAGE_FORMAT = -3;
  static const int TIMEOUT_WAITING_FOR_MESSAGE_LOOP = -5;
  static const int MESSAGE_PROCESSING = -6;
  static const int ASYNC_CALL_FAILED = -7;
  static const int DISPATCH_MESSAGE_FAILED = -8;
  static const int ENGINE_NOT_RUNNING = -9; // Engine が未初期化またはシャットダウン中
  static const int MESSAGE_MANAGER_NOT_EXIST = -10;
  static const int MESSAGE_MANAGER_ALREADY_CREATED = -11;
  static const int UNSUPPORTED_API_VERSION = -12;
  static const int ENGINE_ALREADY_INITIALIZED = -13;
  static const int MESSAGE_MANAGER_ALREADY_INITIALIZED = -14;
  static const int DART_API_NOT_INITIALIZED = -15;
  static const int MESSAGE_MANAGER_NOT_INITIALIZED = -16;
  static const int ENGINE_ALREADY_SHUT_DOWN = -17;
  static const int ENGINE_NOT_SHUT_DOWN = -18;
  static const int MESSAGE_MANAGER_NOT_SHUT_DOWN = -19;
  static const int DART_API_ALREADY_INITIALIZED = -20;
  static const int MESSAGE_MANAGER_ALREADY_SHUT_DOWN = -21;
  static const int DART_API_ALREADY_SHUT_DOWN = -22;
  static const int UDP_CHANNEL_FAILED_TO_START = -23;
}

String getErrorMessage(int statusCode) {
  switch (statusCode) {
    case StatusCodes.SUCCESS:
      return "Success. No error.";
    case StatusCodes.UNKNOWN_ERROR:
      return "Unknown error occurred.";
    case StatusCodes.ENGINE_NOT_INITIALIZED:
      return "Engine not initialized.";
    case StatusCodes.INVALID_MESSAGE_FORMAT:
      return "Invalid message format.";
    case StatusCodes.TIMEOUT_WAITING_FOR_MESSAGE_LOOP:
      return "Timeout waiting for message loop.";
    case StatusCodes.MESSAGE_PROCESSING:
      return "Message is currently being processed.";
    case StatusCodes.ASYNC_CALL_FAILED:
      return "Asynchronous call failed.";
    case StatusCodes.DISPATCH_MESSAGE_FAILED:
      return "Dispatching message failed.";
    case StatusCodes.ENGINE_NOT_RUNNING:
      return "Engine not running or shutting down.";
    case StatusCodes.MESSAGE_MANAGER_NOT_EXIST:
      return "Message manager does not exist.";
    case StatusCodes.MESSAGE_MANAGER_ALREADY_CREATED:
      return "Message manager already created.";
    case StatusCodes.UNSUPPORTED_API_VERSION:
      return "Unsupported API version.";
    case StatusCodes.ENGINE_ALREADY_INITIALIZED:
      return "Engine already initialized.";
    case StatusCodes.MESSAGE_MANAGER_ALREADY_INITIALIZED:
      return "Message manager already initialized.";
    case StatusCodes.DART_API_NOT_INITIALIZED:
      return "Dart API not initialized.";
    case StatusCodes.MESSAGE_MANAGER_NOT_INITIALIZED:
      return "Message manager not initialized.";
    case StatusCodes.ENGINE_ALREADY_SHUT_DOWN:
      return "Engine already shut down.";
    case StatusCodes.ENGINE_NOT_SHUT_DOWN:
      return "Engine not shut down.";
    case StatusCodes.MESSAGE_MANAGER_ALREADY_SHUT_DOWN:
      return "Message manager already shut down.";
    case StatusCodes.MESSAGE_MANAGER_NOT_SHUT_DOWN:
      return "Message manager not shut down.";
    case StatusCodes.DART_API_ALREADY_SHUT_DOWN:
      return "Dart API already shut down.";
    case StatusCodes.DART_API_ALREADY_INITIALIZED:
      return "Dart API already initialized.";
    case StatusCodes.UDP_CHANNEL_FAILED_TO_START:
      return "UDP channel failed to start receiving messages.";
    default:
      return "Unknown status code: $statusCode";
  }
}
