{
  description = "Nix package for the discontinued NexusMods.App";

  nixConfig = {
    commit-lock-file-summary = "chore(flake): update inputs";
    extra-substituters = [
      "https://nexusmods-app-nix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nexusmods-app-nix.cachix.org-1:s/R/lYmFfSfvzZ52h0K/SeSTGPbs4HJGFECegwiIyXs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    systems.url = "github:nix-systems/default-linux";
    systems.flake = false;
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      systems = import inputs.systems;
      forEachSystem = lib.genAttrs systems;
      mainForEachSystem =
        fn:
        forEachSystem (
          system:
          fn (
            import ./main.nix {
              inherit system;
              inherit (inputs) nixpkgs;
            }
          )
        );
    in
    {
      packages = mainForEachSystem (main: {
        default = main.nexusmods-app;
        inherit (main)
          nexusmods-app
          nexusmods-app-unfree
          ;
      });
      formatter = mainForEachSystem (main: main.treefmt);
      checks = mainForEachSystem (main: main.checks);
      overlays.default = import ./overlay.nix;
    };
}
