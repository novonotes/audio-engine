# Sonora App Bridge Plugin

A VST3/AU plugin that bridges audio applications with DAWs via Unix Domain Sockets.

## Settings Configuration

The plugin reads configuration from `settings.json` (or `settings.dev.json` for debug builds).

### File Location
- **macOS**: `~/Library/Application Support/Sonora App Bridge/`
- **Windows**: `%APPDATA%\Sonora App Bridge\`
- **Linux**: `~/.config/Sonora App Bridge/`

### Configuration Fields

```json
{
  "command": "/path/to/your/application",
  "cwd": "/working/directory",
  "args": ["--arg1", "--arg2"],
  "showDevEditor": false
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `command` | string | Yes | Path to the application executable |
| `cwd` | string | No | Working directory (defaults to current directory) |
| `args` | array | No | Command-line arguments to pass to the application |
| `showDevEditor` | boolean | No | Show developer editor UI (defaults to false) |

### Example

```json
{
  "command": "/Applications/BeatGen.app/Contents/MacOS/BeatGen",
  "cwd": "/Applications/BeatGen.app",
  "args": [
    "--audio-engine-uds", "$SOCK_PATH",
    "--plugin-mode"
  ],
  "showDevEditor": false
}
```

**Note**: `$SOCK_PATH` is automatically replaced with the actual socket path at runtime.