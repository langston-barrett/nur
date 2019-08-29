import ../generic-haskell.nix {
  name = "what4";
  additionalInputs = pkgs: unstable: [pkgs.z3];
  additionalHaskellInputs = hpkgs: with hpkgs; [
    lens
    panic
    versions
    tasty
    tasty-hunit
  ];
}
