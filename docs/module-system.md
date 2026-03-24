# Module System

The registry owns tool loading. Each tool is isolated under its own folder.

Recommended shape:

- `server.lua` - server implementation
- `shared.lua` - constants/event names
- `config.lua` - defaults and map rules
