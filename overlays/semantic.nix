pkgs: self: super:

let hlib = pkgs.haskell.lib;
in {
  # auto-yasnippet: SPC i S c
  # ~pkg = super.callPackage ./haskell/semantic/~pkg.nix { };
  semantic = super.callPackage ./haskell/semantic/semantic.nix { };
  freer-cofreer = hlib.dontCheck (super.callPackage ./haskell/semantic/freer-cofreer.nix { });
  fused-effects-exceptions = super.callPackage ./haskell/semantic/fused-effects-exceptions.nix { };
  proto3-suite = hlib.dontCheck (super.callPackage ./haskell/semantic/proto3-suite.nix { });
  proto3-wire = super.callPackage ./haskell/semantic/proto3-wire.nix { };
  fused-effects = hlib.dontCheck (super.callPackage ./haskell/semantic/fused-effects.nix { });

  haskell-tree-sitter = (super.callPackage ./haskell/semantic/haskell-tree-sitter.nix { }).overrideAttrs (oldAttrs: {
    # buildPhase = ''
    #   export NIX_LDFLAGS+=" -L${abc} -L${abc}/lib"
    #   ${oldAttrs.buildPhase}
    # '';
    librarySystemDepends = [ pkgs.tree-sitter ]; # TODO
  });
  # tree-sitter-~lang = super.callPackage ./haskell/semantic/haskell-tree-sitter-~lang.nix { };
  tree-sitter-go = super.callPackage ./haskell/semantic/haskell-tree-sitter-go.nix { };
  tree-sitter-haskell = super.callPackage ./haskell/semantic/haskell-tree-sitter-haskell.nix { };
  tree-sitter-java = super.callPackage ./haskell/semantic/haskell-tree-sitter-java.nix { };
  tree-sitter-json = super.callPackage ./haskell/semantic/haskell-tree-sitter-json.nix { };
  tree-sitter-php = super.callPackage ./haskell/semantic/haskell-tree-sitter-php.nix { };
  tree-sitter-python = super.callPackage ./haskell/semantic/haskell-tree-sitter-python.nix { };
  tree-sitter-ruby = super.callPackage ./haskell/semantic/haskell-tree-sitter-ruby.nix { };
  tree-sitter-typescript = super.callPackage ./haskell/semantic/haskell-tree-sitter-typescript.nix { };

  # ~pkg = hlib.dontCheck super.~pkg;
  semilattices = hlib.dontCheck  super.semilattices;
  heap = hlib.dontCheck super.heap;
  kdt = hlib.dontCheck super.kdt;
  range-set-list = hlib.dontCheck super.range-set-list;
}
