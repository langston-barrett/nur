import ../generic-haskell.nix {
  name = "saw-script";
  additionalHaskellInputs = hpkgs: with hpkgs; [ alex happy ];
}
