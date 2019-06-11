import ../generic-haskell.nix {
  name = "saw-script";
  additionalHaskellInputs = hpkgs: with hpkgs; [ alex happy ];
  additionalInputs = pkgs: unstable: with pkgs; [
    abc
    unstable.yices
    z3
  ];
}
