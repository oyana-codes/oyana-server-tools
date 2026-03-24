# Map Capabilities

Map support should be declarative.

Example:

```lua
return {
  west_coast_usa = {
    supports = {
      countdown = true,
      flood = true,
      admin = true
    }
  }
}
```
