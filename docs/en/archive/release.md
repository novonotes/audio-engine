# Release

How to release a new version of AudioEngine. For maintainers.

## Release build

## macOS

To build a universal binary for release:

```
    cmake -B build -G Xcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64"
    cmake --build build
```