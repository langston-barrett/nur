pkgs: self: super:

let hlib = pkgs.haskell.lib;
    # TODO: per-package wrappers
    update = name: {
      "${name}" = hlib.dontCheck (hlib.doJailbreak (super.callPackage (./. + "/../pkgs/haskell/updates/${name}.nix") { }));
    };
in pkgs.lib.zipAttrsWith (name: vals: builtins.elemAt vals 0)
                         (builtins.map update (import ./packages.nix))
