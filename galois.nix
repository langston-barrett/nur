# * Galois Haskell package set
#
# A package set with (./default.nix).overlays.haskellPackages.galois applied.

{ compiler ? "ghc864" }:

# Get the set of overlays from ./default.nix
let nur = pkgs: import ./default.nix { inherit pkgs; };

in import ./nixpkgs.nix { } {
  config = {
    allowUnfree = true; # https://github.com/GaloisInc/flexdis86/pull/1 # TODO: still necessary?
    allowBroken = true; # GHC 8.8.1, bytestring-handle
  };
  overlays = [
    (self: super: { abc = (nur super).abc; })
    (self: super: {
      haskellPackages =
        (nur super).overlays.haskellPackages.galois self super;
    })
  ];
}
