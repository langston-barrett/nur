# * A pinned version of nixpkgs
#
# nix-shell --pure -p nix-prefetch-git --run "nix-prefetch-git https://github.com/NixOS/nixpkgs.git 19.03 > json/nixpkgs/19.03.json"
#
{ pkgsOld ? import <nixpkgs> { }
, path ? ./json/nixpkgs/20.03-beta.json
}:

let
  nixpkgs = builtins.fromJSON (builtins.readFile path);

  src = pkgsOld.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

#in import src
in import <nixpkgs>
