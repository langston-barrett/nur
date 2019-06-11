# * Local builds
#
# These overlays can be used to override where we fetch the source of various
# packages, specifically so we can use locally-modified versions.

pkgs: self: super:

let hlib = pkgs.haskell.lib;
  srcFilter =
    path: pkgs.lib.sourceFilesBySuffices
            path [".hs" "LICENSE" "cabal" ".c" ".sawcore"];

  # Give an explicit path for a new source
  alterSrc = pkg: path: pkg.overrideDerivation (_: {
    src = srcFilter path;
  });

  # Add dependencies
  addDeps = pkg: path: deps: pkg.overrideAttrs (oldAttrs: {
    src = srcFilter path;
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ deps;
  });

  # Change the JSON file used for the source fetching
  # Doesn't quite work.
  alterSrcJSON = pkg: name: json: alterSrc pkg
    (let fromJson = builtins.fromJSON (builtins.readFile json);
    in pkgs.fetchFromGitHub {
         owner = "GaloisInc";
         repo  = name;
         inherit (fromJson) rev sha256;
       });

  dontCheck = pkg: pkg.overrideDerivation (_: { doCheck = false; });

  maybeSuffix = suffix: if suffix == "" then "" else "-" + suffix;

in with super; {
  # Use with auto-yasnippet (SPC i S c)
  # ~pkg = alterSrc ~pkg (../~pkg);
  saw-script     = alterSrc saw-script (../../saw-script);
}
//

# ** Macaw

(with super; {
  # macaw-base         = alterSrc macaw-base (../macaw/base);
  # macaw-symbolic     = alterSrc macaw-symbolic (../macaw/symbolic);
  # macaw-x86-symbolic = alterSrc macaw-x86-symbolic (../macaw/x86_symbolic);
  # macaw-x86          = alterSrc macaw-x86 (../macaw/x86);
})
//

# ** Crucible

(with super; {
  crucible            = alterSrc crucible (../../crucible/crucible);
  crucible-llvm       = alterSrc crucible-llvm (../../crucible/crucible-llvm);
  crucible-jvm        = alterSrc crucible-jvm (../../crucible/crucible-jvm);
  parameterized-utils = alterSrc parameterized-utils (../parameterized-utils);
  what4               = addDeps what4 (../../crucible/what4) [versions];
  # what4               = alterSrc what4 (../../crucible/what4);
})
//

# ** llvm-pretty-*

(with super; {
  # llvm-pretty = alterSrc llvm-pretty (../llvm-pretty-bc-parser/llvm-pretty);
  # llvm-pretty-bc-parser = alterSrc llvm-pretty-bc-parser (../llvm-pretty-bc-parser);
})
//

# ** saw-core

(with super; {
  # saw-core-what4 = alterSrc saw-core-what4 (../saw-core-what4);
})
