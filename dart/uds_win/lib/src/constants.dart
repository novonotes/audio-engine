// ignore_for_file: constant_identifier_names

/// Indicates a socket error, typically returned by a Winsock function call.
const SOCKET_ERROR = -1;

/// Represents an invalid socket handle, returned when socket creation fails.
const INVALID_SOCKET = -1;

/// Maximum number of connections allowed for a socket in a listen state.
/// SOMAXCONN can be used to specify the maximum queue length for pending connections.
const SOMAXCONN = 0x7FFFFFFF;

/// Flag to set or get a socket's non-blocking mode using ioctl().
/// FIONBIO is typically used with Winsock functions.
const FIONBIO = 0x8004667E;

/// Error code indicating that a non-blocking operation cannot be completed immediately.
/// Commonly encountered when using non-blocking sockets.
const WSAEWOULDBLOCK = 10035;

const WSAENOTSOCK = 10038;
const WSAECONNRESET = 10054;
const WSAEADDRINUSE = 10048;

/// Maximum length of a Unix domain socket path.
/// Only applicable for sockaddr structures used in AF_UNIX or similar contexts.
const SOCKADDR_PATH_LENGTH = 108;
