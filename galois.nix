# * Galois Haskell package set
#
# A package set with (./default.nix).overlays.haskellPackages.galois applied.

{ compiler ? "ghc864" }:

# Get the set of overlays from ./default.nix
let nur = pkgs: import ./default.nix { inherit pkgs; };

in import ./nixpkgs.nix { } {
  config = {
    allowBroken = true; # GHC 8.8.1, bytestring-handle
  };
  overlays =
    # Non-Haskell packages
    [ (self: super: { abc = (nur super).abc; }) ] ++

    # Packages that need newer versions from Github
    (let
      update = name: (self: super: {
        haskellPackages =
          (nur super).overlays.haskellPackages.${name} self super;
      });
    in builtins.map update [ "crackNum" "sbv" "itanium-abi" ]) ++

    # Galois packages
    (let
      addGalois = name: (self: super: {
        haskellPackages =
          (nur super).overlays.haskellPackages.${name} self super;
      });
      galoisPackages = import ./lib/galois-packages.nix;
    in builtins.map addGalois galoisPackages) ++

    # local packages
    (let
      addLocal = name: (self: super: {
        haskellPackages =
          (nur super).overlays.localHaskellPackages.${name} self super;
      });
    in builtins.map addLocal [ "crucible" "crucible-llvm" "crucible-jvm" "what4" ]);
}
