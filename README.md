# audio-engine
A monorepo providing an audio engine for production applications—DAWs, audio editors, and DAW plugins—with integration code for app frameworks.

This is a general-purpose audio engine implementation designed to be used as a component for a wide range of applications, not limited to specific NovoNotes products.

The following usage methods are available:

- **Audio Engine Modules**: Suitable for integration into JUCE plugins and other C++ applications. See usage examples in [ExamplePlugin](./sonora/ExamplePlugin).
- **Audio Engine Service**: A standalone program that can be launched as a subprocess from other applications and controlled via inter-process communication.
- **Audio Engine Library**: A dynamically loadable library that exposes a C API designed for use from other languages. Currently implemented only for use from Dart, but designed to be extensible in the future.