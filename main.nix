{
  nixpkgs ? <nixpkgs>,
  system ? builtins.currentSystem,
  pkgs ? import nixpkgs { inherit system; },
}:
let
  nexusmods-app = pkgs.callPackage ./package/nexusmods-app.nix { };
  treefmt = pkgs.callPackage ./treefmt { };
in
{
  inherit nexusmods-app treefmt;
  nexusmods-app-unfree = nexusmods-app.override {
    _7zz = pkgs._7zz-rar;
  };
  checks = nexusmods-app.tests // {
    treefmt = treefmt.check ./.;
  };
  overlay = import ./overlay.nix;
}
