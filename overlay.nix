final: prev:
let
  main = import ./main.nix { pkgs = final; };
in
{
  inherit (main)
    nexusmods-app
    nexusmods-app-unfree
    ;
}
