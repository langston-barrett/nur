import ../generic-haskell.nix {
  name = "crucible-llvm";
  additionalInputs = pkgs: unstable: [pkgs.clang_7 pkgs.llvm_7];
  additionalHaskellInputs = hpkgs: with hpkgs; [
    tasty
    tasty-golden
    tasty-hunit
    tasty-quickcheck
    QuickCheck
  ];
}