# Packaging

## Working structure

```txt
Resources/
├─ Server/
│  └─ OyanaServerTools/
└─ Client/
   └─ OyanaServerTools.zip
```

## Source of truth

- Server Lua source lives directly in `Resources/Server/OyanaServerTools`
- Client source lives in `client-src/OyanaServerTools`
- The packaged client zip is written to `Resources/Client/OyanaServerTools.zip`

## Build steps

1. Build Angular separately.
2. Run `npm run build:ui` to copy the compiled UI into the client mod source.
3. Run `npm run package:client` to create `Resources/Client/OyanaServerTools.zip`.
4. Run `npm run package` to also create a release zip in `release/OyanaServerTools-release.zip`.
