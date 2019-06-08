{ compiler  ? "ghc864" }:
{
  haskellPackages = {

    # A Haskell package set overlay for building github/semantic
    semantic = self: super: super.haskellPackages.override {
      overrides = haskellPackagesNew: haskellPackagesOld:
        import ./semantic.nix super haskellPackagesNew haskellPackagesOld;
    };

    # A Haskell package set overlay for building GaloisInc/*
    galois = self: super: super.haskellPackages.override {
      overrides = haskellPackagesNew: haskellPackagesOld:
        (import ./galois.nix super haskellPackagesNew haskellPackagesOld) { };
    };
  };

}

