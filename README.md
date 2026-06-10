# NexusMods.App Nix package

> [!CAUTION]
> NexusMods.App has been [discontinued] upstream and will soon be removed from Nixpkgs.
> This project packages the final upstream release for Nix users who still rely on NexusMods.App.
>
> New users should use a [maintained mod manager](#alternatives).

This repository exists to preserve access to NexusMods.App after its removal from Nixpkgs.

[NexusMods.App] is a mod manager for:
- Baldur's Gate 3
- Cyberpunk 2077
- Mount & Blade II: Bannerlord
- Stardew Valley

Support for some games is better than others, as the project was discontinued during an early phase of its development.

## Discontinued

NexusMods.App was [discontinued] by Nexus Mods during the early stages of its development.
It is currently functional for a handful of games, but no longer receives updates,
including security fixes, compatibility updates, or support for future game updates.

Nexus Mods have moved the NexusMods.App team to work on improving their existing mod manager, [Vortex].
Vortex currently only supports Windows, but there are plans to add Linux support.
Vortex can also be run via Wine or Proton, but it can be challenging to set it up to work smoothly.

### Alternatives

- [limo] simple native QT mod manager (Flatpack, AUR, Nixpkgs)
- [Vortex]
  - Native Linux (eventually)
  - [SteamTinkerLaunch]
  - [NaK] (archived, use older releases for Vortex)
- [Mod Organizer 2]
  - [SteamTinkerLaunch]
  - [NaK] (archived, use newer releases for MO2)
  - [Fluorine Manager] an attempt at porting Mod Organizer 2 to Linux with FUSE

## Usage

You can consume this project with or without flakes.

```nix
# Flake
{
  inputs.nexusmods-app.url = "github:MattSturgeon/nma-nix";
}
```

```nix
# Non-flake
# Replace `<commit>` with the desired Git revision and update the SHA-256 hash.
let
  nma-rev = "<commit>";
  nma = builtins.fetchTarball {
    url = "https://github.com/MattSturgeon/nma-nix/archive/${nma-rev}.tar.gz";
    sha256 = "";
  };
in
import "${nma}/overlay.nix"
```

### Packages

- `nexusmods-app` is a fully FOSS build of NexusMods.App.
- `nexusmods-app-unfree` enables RAR archive support through 7-Zip.
  The package is marked unfree due to the licensing status of RAR support.

### Overlay

`./overlay.nix` and the `overlays.default` flake output provide a Nixpkgs overlay that adds the above packages to the package set.

### Cachix

You can use our Cachix binary cache to download pre-built packages.

```bash
cachix use nexusmods-app-nix
```

Manual configuration:

URL:
```
https://nexusmods-app-nix.cachix.org
```

Public key:
```
nexusmods-app-nix.cachix.org-1:s/R/lYmFfSfvzZ52h0K/SeSTGPbs4HJGFECegwiIyXs=
```

## Maintenance

Upstream development has ended.
This repository maintains packaging for the final upstream release of NexusMods.App.

Packaging fixes and Nixpkgs compatibility updates may be accepted,
but no effort is made to patch application bugs, security issues, or game compatibility problems.

[NexusMods.App]: https://github.com/Nexus-Mods/NexusMods.App
[discontinued]: https://www.nexusmods.com/news/15424
[limo]: https://github.com/limo-app/limo
[Vortex]: https://www.nexusmods.com/vortex
[Mod Organizer 2]: https://github.com/Modorganizer2/modorganizer
[SteamTinkerLaunch]: https://github.com/sonic2kk/steamtinkerlaunch
[NaK]: https://github.com/SulfurNitride/NaK
[Fluorine Manager]: https://github.com/SulfurNitride/Fluorine-Manager
