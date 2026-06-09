{
  lib ? import <nixpkgs/lib>,
  gamesJson ? builtins.readFile ./games.json,
}:
let
  ids = import ./game-ids.nix;
  games = lib.importJSON gamesJson;
in
lib.forEach games (
  { id, name, ... }:
  lib.throwIfNot (
    id == ids.${name}
  ) "${name}: id ${toString id} does not match ${toString ids.${name}}" null
)
