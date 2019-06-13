pkgs: self: super:

let hlib = pkgs.haskell.lib;
in {
  # auto-yasnippet: SPC i S c
  crackNum = super.callPackage ./pkgs/haskell/updates/crackNum.nix { };
  sbv = super.callPackage ./pkgs/haskell/updates/sbv.nix { };
  itanium-abi = super.callPackage ./pkgs/haskell/updates/itanium-abi.nix { };
  th-abstraction = super.callPackage ./pkgs/haskell/updates/th-abstraction.nix { };
}
