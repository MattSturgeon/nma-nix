{
  nixpkgs ? null,
  system ? null,
  pkgs ? null,
}@args:
let
  main = import ./main.nix args;
in
main.nexusmods-app // main
