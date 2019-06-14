{ pkgs
, lib
, compiler  ? "ghc864"
}:
{
  haskellPackages =
    pkgs.lib.zipAttrsWith (name: vals: builtins.elemAt vals 0) ([
      {
        # A Haskell package set overlay for building github/semantic
        semantic = self: super: super.haskellPackages.extend (new: old:
          import ./semantic.nix super new old
        );
      }] ++
      # TODO: de-duplicate with contents of ./updates.nix
      (let
        update = name: {
          "${name}" = self: super: super.haskellPackages.extend (new: old: {
            "${name}" = (import ./updates super new old).${name};
          });
        };
      in builtins.map update (import ./updates/packages.nix ++ ["hpack"])) ++
      (let
        # Add another haskell package set overlay for a given package in the
        # ./galois.nix file.
        addGalois = name: {
          "${name}" = self: super: super.haskellPackages.extend (new: old: {
            "${name}" = ((import ./galois.nix super new old) { }).${name};
          });
        };
        galoisPackages = import ../lib/galois-packages.nix;
      in builtins.map addGalois galoisPackages));

  localHaskellPackages =
    pkgs.lib.zipAttrsWith (name: vals: builtins.elemAt vals 0)
      (let
        update = name: {
          "${name}" = self: super: super.haskellPackages.extend (new: old: {
            "${name}" = (import ./local.nix super new old).${name};
          });
        };
      in builtins.map update [
           "crucible"
           "crucible-jvm"
           "crucible-llvm"
           "what4"
           "parameterized-utils"
           "saw-script"
         ]);
}
