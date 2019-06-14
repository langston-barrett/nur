# TODO: use generic-haskell.nix
{ pkgs ? import ../nixpkgs.nix { } { } }:

let this = import ./default.nix { inherit pkgs; };
in with pkgs; pkgs.mkShell {
  LANG = "en_US.utf8";
  LC_CTYPE = "en_US.utf8";
  LC_ALL = "en_US.utf8";
  buildInputs = [
    glibcLocales # https://github.com/commercialhaskell/stack/issues/793

    (pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
    ] ++ this.buildInputs
      ++ this.propagatedBuildInputs))

    pkgs.haskellPackages.ghcid
    # pkgs.haskellPackages.hlint
    # pkgs.haskellPackages.apply-refact
    haskellPackages.cabal-install
  ];
}
