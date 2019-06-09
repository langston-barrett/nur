# * galois

pkgs: self: super:

{ build ? "master" }:

# ** utilities

let hlib = pkgs.haskell.lib;
    lib = import ../lib { inherit pkgs; };
    mk = lib.haskell.mk {
      haskellPackages = super;
      # TODO: "string '/nix/store/yi...-source/' cannot refer to other paths"
      # inherit (pkgs.lib) sourceFilesBySuffices;
    };
    wrappers = lib.haskell.wrappers;

    sourceMaster = name: ./. + "/json/haskell/galois/master/${name}.json";
    sourceCase = name: ./. + "/json/haskell/galois/${build}/${name}.json";

    withSubdirs = pname: suffixToSubdir: suffix: mk {
      json   = sourceCase "${pname}";
      # name   = pname + maybeSuffix suffix; # TODO: use this
      name   = pname + "-" + suffix;
      repo   = pname;
      subdir = suffixToSubdir suffix;
    };

    # Packages that require no modification
    fromSourceFun = f: name: {
      "${name}" = mk {
        name = "${name}";
        json = f "${name}";
      };
    };
    fromSource = fromSourceFun sourceCase;
    fromMaster = fromSourceFun sourceMaster;
in {
  aig = mk {
    name = "aig";
    json   = ./json/haskell/galois/master/aig.json;
    wrapper = wrappers.jailbreakDefault; # base >=4 && <4.12
  };

  binary-symbols = mk {
    name   = "binary-symbols";
    repo   = "flexdis86";
    subdir = "binary-symbols";
    json   = ./json/haskell/galois/master/flexdis86.json;
  };

  abcBridge = wrappers.default
    (super.callPackage ./pkgs/haskell/galois/abcBridge.nix { });

  cryptol-verifier = lib.addABC (mk {
    name = "cryptol-verifier";
    json = sourceCase"cryptol-verifier";
  });

  elf-edit = mk {
    name = "elf-edit";
    json = ./json/haskell/galois/master/elf-edit.json;
  };

  galois-dwarf = mk {
    name = "dwarf";
    json = ./json/haskell/galois/master/dwarf.json;
  };

  # Tests fail because they lack llvm-as
  llvm-pretty-bc-parser = mk {
    name = "llvm-pretty-bc-parser";
    json = ./json/haskell/galois/master/llvm-pretty-bc-parser.json;
  };

  llvm-verifier = lib.addABC (mk {
    name = "llvm-verifier";
    json = ./json/haskell/galois/master/llvm-verifier.json;
  });

  llvm-pretty = mk {
    name = "llvm-pretty";
    owner = "elliottt";
    json = ./json/haskell/galois/master/llvm-pretty.json;
  };

  # The version on Hackage should work, its just not in nixpkgs yet
  parameterized-utils = mk {
    name = "parameterized-utils";
    json = sourceCase"parameterized-utils";
    wrapper = wrappers.jailbreakDefault;
  };
} // fromSource "cryptol"
  // fromMaster "flexdis86"
  // fromMaster "jvm-parser"
  // fromMaster "jvm-verifier"
  //

# ** crucible

(let
  maybeSuffix = suffix: if suffix == "" then "" else "-" + suffix;

  crucibleF = withSubdirs "crucible"
                (suffix: "crucible" + maybeSuffix suffix);

  # A package in a subdirectory of Crucible
  useCrucible = name: mk {
    inherit name;
    json   = sourceCase"crucible";
    repo   = "crucible";
    subdir = name;
  };

  # We disable tests because they rely on external SMT solvers
  what4 = suffix:
    let name = "what4" + maybeSuffix suffix;
    in useCrucible name;

in {

  what4     = what4 "";
  # what4-sbv = what4 "sbv";
  what4-abc = lib.addABC (what4 "abc");

  # crucible-server = crucibleF "server";
  # crucible-syntax = crucibleF "syntax";
  crucible      = crucibleF "";
  crucible-jvm  = crucibleF "jvm";
  crucible-llvm = crucibleF "llvm";
  crucible-saw  = crucibleF "saw";
  crux          = useCrucible "crux";
  crux-llvm     = useCrucible "crux-llvm";

}) //

# ** macaw

(let
  macaw = withSubdirs "macaw" (suffix: suffix);
in {
  macaw-base         = macaw "base";
  macaw-x86          = macaw "x86";
  macaw-symbolic     = macaw "symbolic";
  macaw-x86-symbolic = macaw "x86_symbolic";
}) //

# ** saw

({
  saw-script = lib.addABC (mk {
    name    = "saw-script";
    json    = ./json/haskell/galois/master/saw-script.json;
    wrapper = wrappers.exe;
  });
}) // fromSource "saw-core"
   // fromSource "saw-core-aig"
   // fromSource "saw-core-sbv" # takes a long time to build
   // fromSource "saw-core-what4" # takes a long time to build
