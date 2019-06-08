pkgs: self: super:

{ build ? "master" }:

let hlib = pkgs.haskell.lib;
    lib = import ../lib { inherit pkgs; };
    mk = lib.haskell.mk {
      haskellPackages = super;
    };
    wrappers = lib.haskell.wrappers;
    sources =
      let
        case = arg: arg."${build}" or arg.master;
      in {
        # auto-yasnippet: SPC i S c
        # ~pkg = case {
        #   saw    = ./json/haskell/galois/saw/~pkg.json;
        #   master = ./json/haskell/galois/master/~pkg.json;
        # };
        crucible = case {
          saw    = ./json/haskell/galois/saw/crucible.json;
          master = ./json/haskell/galois/master/crucible.json;
        };
        cryptol = case {
          saw    = ./json/haskell/galois/saw/cryptol.json;
          master = ./json/haskell/galois/master/cryptol.json;
        };
        cryptol-verifier = case {
          saw    = ./json/haskell/galois/saw/cryptol-verifier.json;
          master = ./json/haskell/galois/master/cryptol-verifier.json;
        };
        macaw = case {
          saw    = ./json/haskell/galois/saw/macaw.json;
          master = ./json/haskell/galois/master/macaw.json;
        };
        llvm-pretty = case {
          saw    = ./json/haskell/galois/saw/llvm-pretty.json;
          master = ./json/haskell/galois/master/llvm-pretty.json;
        };
        parameterized-utils = case {
          saw    = ./json/haskell/galois/saw/parameterized-utils.json;
          master = ./json/haskell/galois/master/parameterized-utils.json;
        };
        saw-core = case {
          saw    = ./json/haskell/galois/saw/saw-core.json;
          master = ./json/haskell/galois/master/saw-core.json;
        };
        saw-core-aig = case {
          saw    = ./json/haskell/galois/saw/saw-core-aig.json;
          master = ./json/haskell/galois/master/saw-core-aig.json;
        };
        saw-core-sbv = case {
          saw    = ./json/haskell/galois/saw/saw-core-sbv.json;
          master = ./json/haskell/galois/master/saw-core-sbv.json;
        };
        saw-core-what4 = case {
          saw    = ./json/haskell/galois/saw/saw-core-what4.json;
          master = ./json/haskell/galois/master/saw-core-what4.json;
        };
      };
in {
  # The version on Hackage should work, its just not in nixpkgs yet
  parameterized-utils = mk {
    name = "parameterized-utils";
    json = sources.parameterized-utils;
    wrapper = wrappers.jailbreakDefault;
  };
}
