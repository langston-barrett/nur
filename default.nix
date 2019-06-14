{ pkgs ? import ./nixpkgs.nix { } { } }:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays { inherit pkgs lib; }; # nixpkgs overlays

  abc = pkgs.callPackage ./pkgs/abc.nix { };
  jsonlines = pkgs.callPackage ./pkgs/jsonlines.nix {
    inherit (pkgs.pythonPackages) buildPythonPackage fetchPypi six;
  };
}

