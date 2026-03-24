# Oyana Server Tools

Modular BeamMP server tools with a shared client mod and Angular-based UI.

## Goals

- Modular server-side tools
- Shared client UI/runtime bridge
- Map capability checks
- Easy packaging into `Resources/Server` and `Resources/Client`
- Clean foundation for flood tools, countdowns, and future server features

## Repo layout

- `Resources/Server/OyanaServerTools` - BeamMP server resource source
- `Resources/Client` - generated client zip output for BeamMP
- `client-src/OyanaServerTools` - client mod source that becomes `Resources/Client/OyanaServerTools.zip`
- `ui/angular-app` - Angular source project
- `tools` - local build and packaging scripts
- `docs` - architecture notes

## Commands

- `npm run build:ui` - copy built Angular output into the client mod source
- `npm run package:client` - build `Resources/Client/OyanaServerTools.zip`
- `npm run package:server` - validate the server resource structure
- `npm run package` - generate the client zip and a release zip

## Expected BeamMP layout

```txt
Resources/
├─ Server/
│  └─ OyanaServerTools/
└─ Client/
   └─ OyanaServerTools.zip
```

## Suggested dev flow

1. Implement or expand a server tool in `Resources/Server/OyanaServerTools/tools/<tool>`
2. Add matching client hooks in `client-src/OyanaServerTools/lua/.../tools/<tool>.lua`
3. Add UI in `ui/angular-app/src/app/features/<tool>`
4. Build Angular and copy it into `client-src/OyanaServerTools/ui/modules/oyana-server-tools`
5. Run `npm run package:client` to refresh `Resources/Client/OyanaServerTools.zip`

## Notable starter modules

- Countdown
- Flood
- Map capabilities
- Admin
