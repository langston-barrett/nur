{ pkgs ? import ./nixpkgs.nix { } { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays { }; # nixpkgs overlays

  abc = pkgs.callPackage ./pkgs/abc.nix { };
}

