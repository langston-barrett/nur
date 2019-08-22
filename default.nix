{ pkgs ? import ./nixpkgs.nix { } { }
, profiling ? false
}:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays { inherit pkgs lib profiling; }; # nixpkgs overlays

  abc = pkgs.callPackage ./pkgs/abc.nix { };
  constexpr-everything = pkgs.callPackage ./pkgs/constexpr-everything.nix { };
  jsonlines = pkgs.callPackage ./pkgs/jsonlines.nix {
    inherit (pkgs.pythonPackages) buildPythonPackage fetchPypi six;
  };
  scalastyle = pkgs.callPackage ./pkgs/scalastyle.nix { };
}
