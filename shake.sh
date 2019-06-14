#!/usr/bin/env bash

CABAL_FILE=shake/nur.cabal

if ! [[ -f $CABAL_FILE ]]; then
  echo "You should run this script from the root of the source tree."
fi;

cd shake
cmd="cabal new-run exe:nur -- -C .. $@"
echo "$cmd"
nix-shell \
  -p 'with import ../galois.nix { }; haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [ shake ])' \
  -p haskellPackages.cabal-install \
  --run "$cmd"
# --pure \
