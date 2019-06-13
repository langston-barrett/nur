pkgs: self: super:

let hlib = pkgs.haskell.lib;
    update = name: {
      "${name}" = super.callPackage (./. + "/../pkgs/haskell/updates/${name}.nix") { };
    };
in pkgs.lib.zipAttrsWith (name: vals: builtins.elemAt vals 0)
                         (builtins.map update (import ./packages.nix))
