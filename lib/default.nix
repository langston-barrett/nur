{ pkgs }:

with pkgs.lib; {
  haskell =
    let hlib = pkgs.haskell.lib;
    in rec {

    # A convenience function for building Haskell packages from Github. Reads in
    # a JSON describing the git revision and SHA256 to fetch, then calls
    # cabal2nix on the source.
    mk =
      { haskellPackages }:

      { name
      , json
      , owner ? "GaloisInc"
      , repo ? name
      , subdir ? ""
      , wrapper ? wrappers.default
      }:

      let
        fromJson = builtins.fromJSON (builtins.readFile json);

        src = sourceFilesBySuffices
          ((pkgs.fetchFromGitHub {
            inherit owner repo;
            inherit (fromJson) rev sha256;
          }) + "/" + subdir) [".hs" "LICENSE" "cabal" ".c"];

      in builtins.trace ("mk: " + name)
            (wrapper
            (haskellPackages.callCabal2nix name src { }));
            
    # "Wrappers" to be applied to Haskell package definitions, mostly for the
    # purposes of faster builds.
    wrappers =
      let
        # This is in newer nixpkgs
        disableOptimization =
            pkg: hlib.appendConfigureFlag pkg "--disable-optimization";
      in rec {
        nocov            = x: hlib.dontCoverage x;
        noprof           =
          x: hlib.disableExecutableProfiling
              (hlib.disableLibraryProfiling (nocov x));
        notest           = x: hlib.dontCheck (noprof x);
        exe              = x: hlib.justStaticExecutables (wrappers.default x);
        jailbreak        = x: hlib.doJailbreak x;
        jailbreakDefault = x: wrappers.jailbreak (wrappers.default x);
        #
        fast    = x: disableOptimization (notest x);
        good    = x: hlib.dontCheck (nocov x);
        default = notest;
      };
  };
}

