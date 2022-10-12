{ pkgs ? import ./nixpkgs.nix { } { }
, profiling ? false
, pythonPackages ? pkgs.python37Packages
}:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays { inherit pkgs lib profiling; }; # nixpkgs overlays

  abc = pkgs.callPackage ./pkgs/abc.nix { };
  constexpr-everything = pkgs.callPackage ./pkgs/constexpr-everything.nix { };
  factpp = pkgs.callPackage ./pkgs/fact.nix { };
  orgparse = pythonPackages.callPackage ./pkgs/orgparse.nix { };
  jsonlines = pkgs.callPackage ./pkgs/jsonlines.nix {
    inherit (pkgs.pythonPackages) buildPythonPackage fetchPypi six;
  };
  shell-hydra = pkgs.callPackage ./sub/shell-hydra/default.nix { };
  scalastyle = pkgs.callPackage ./pkgs/scalastyle.nix { };
  kmonad = pkgs.haskell.packages.ghc8107.callPackage ./pkgs/kmonad.nix { };
  worgle = pkgs.callPackage ./pkgs/worgle.nix { };

  blight = pythonPackages.callPackage ./pkgs/blight.nix { };
  mbuild = pythonPackages.callPackage ./pkgs/mbuild.nix { };
  xed = pkgs.callPackage ./pkgs/xed.nix { inherit mbuild; };
  pyxed = pythonPackages.callPackage ./pkgs/pyxed.nix { inherit xed; };
}
