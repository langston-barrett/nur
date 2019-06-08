{ compiler  ? "ghc864" }:
{
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;
  haskellPackages = self: super: super.haskellPackages.override {
    overrides = haskellPackagesNew: haskellPackagesOld: {
      semantic = super.callPackage ./haskell/semantic/semantic.nix { };
    } // (import ./semantic.nix super haskellPackagesNew haskellPackagesOld);
  };
}

