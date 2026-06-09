# NexusMods.App Nix package

> [!CAUTION]
> NexusMods.App has been [discontinued] upstream.
> This project is intended for users with existing installations.
>
> New users should use a [maintained mod manager](#alternatives).

NexusMods.App is a discontinued mod installer, creator and manager for:
- Baldur's Gate 3
- Cyberpunk 2077
- Mount & Blade II: Bannerlord
- Stardew Valley

Support for some games is better than others, as the project was discontinued during an early phase of its development.

## Discontinued

NexusMods.App was [discontinued] by Nexus Mods during the early stages of its development.
It is currently functional for a handful of games, but does not receive updates,
including security updates or fixes for _game_ updates.

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
let
  # You will need to update the commit hash and sha256 output hash.
  nma-rev = "todo";
  nma = builtins.fetchTarball {
    url = "https://github.com/MattSturgeon/nma-nix/archive/${nma-rev}.tar.gz";
    sha256 = "";
  };
in
import "${nma}/overlay.nix"
```

### Packages

`nexusmods-app` is a fully FOSS build of NexusMods.App.

`nexusmods-app-unfree` is NexusMods.App built with RAR-archive support.
It is unfree _only_ because 7-Zip's RAR support licensing is unclear.

### Overlay

`./overlay.nix` and the `overlays.default` flake output provide a Nixpkgs overlay that adds the above packages to the package set.

[discontinued]: https://www.nexusmods.com/news/15424
[limo]: https://github.com/limo-app/limo
[Vortex]: https://www.nexusmods.com/vortex
[Mod Organizer 2]: https://github.com/Modorganizer2/modorganizer
[SteamTinkerLaunch]: https://github.com/sonic2kk/steamtinkerlaunch
[NaK]: https://github.com/SulfurNitride/NaK
[Fluorine Manager]: https://github.com/SulfurNitride/Fluorine-Manager
