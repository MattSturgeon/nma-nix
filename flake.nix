{
  description = "Nix package for the discontinued NexusMods.App";

  nixConfig = {
    commit-lock-file-summary = "chore(flake): update inputs";
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
