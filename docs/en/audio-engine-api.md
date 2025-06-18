# AudioEngineAPI

AudioEngine API is the interface between AudioEngine (hereinafter referred to as the engine) and applications that control and use the engine (hereinafter referred to as applications).
Since the engine and applications may run in separate processes or on different devices, or be implemented in different languages, there are various constraints on communication. The purpose of this API is to enable efficient and flexible engine operations under these constraints.

## Protocol

Communication is asynchronous bidirectional communication by sending Messages.

The engine is defined as the client and the application as the server. The reasons are as follows:

- The engine makes connection requests to the application.
- Since the engine supports use as a plugin, its lifetime depends on other host applications. For this reason, it is technically difficult to implement it as a "server" that prepares a port and waits for connections.
- Supports connections with multiple engines for a single application.
- Use cases where a single engine instance connects to multiple applications are not supported.

### Message Format

Complies with [NAM](nam-v1.md).
The data format of the message body and context data format not specified in NAP shall be the Protobuf binary format defined in the [APIs package](../../APIs/novonotes/audio_engine/README.md).

### Message Transfer Method

The message transfer method varies by engine type as follows:

- **Audio Engine Library**: Dart FFI
- **Audio Engine Service**: Unix Domain Socket
- **Audio Engine Plugin**: Unix Domain Socket

### Reference Implementation

The implementation of each package in this repository serves as the reference implementation.
For ambiguous parts or detailed specifications not fully covered in this document, they are concretized by these reference implementations.