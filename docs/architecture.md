# Architecture

## Layers

- Server Lua: authoritative state, commands, permissions, map capabilities
- Client Lua: event bridge, runtime integration, sounds, UI dispatch
- Angular UI: presentation and controls

## Tool model

Every tool should expose a consistent interface:

- `name`
- `init(ctx)`
- optional lifecycle hooks like `onChatMessage`, `onPlayerConnected`, `onServerTick`
- `shutdown(ctx)`

## Event prefix

Use `OST:` for cross-layer events.
