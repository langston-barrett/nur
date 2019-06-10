import ../generic-haskell.nix {
  name = "saw-script";
  additionalHaskellInputs = hpkgs: with hpkgs; [ alex happy ];
  additionalInputs = pkgs: unstable: with pkgs; [
    (pkgs.callPackage ../../galois-haskell-nix/pkgs/abc.nix { })
    unstable.yices
    z3
  ];
}
