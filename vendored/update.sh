#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash curl jq

set -eu -o pipefail

url='https://data.nexusmods.com/file/nexus-data/games.json'
self=$(realpath "$0")
tmp=$(mktemp)

clean_up() {
  rm -rf "$tmp"
}
trap clean_up EXIT

cd "$(dirname "$self")"

ids=$(
  nix-instantiate --eval --strict --json --expr '
    builtins.attrValues (import ./game-ids.nix)
  '
)

echo "Fetching games data" >&2
curl "$url" \
  --silent \
  --show-error \
  --location |
  jq --argjson ids "$ids" '
    map(select( .id | IN($ids[]) )) | sort_by(.id)
  ' >"$tmp"

echo "Validating result" >&2
nix-instantiate --eval --strict validate.nix --argstr gamesJson "$tmp" >/dev/null

echo "Installing games.json to $PWD" >&2
mv --force "$tmp" games.json
