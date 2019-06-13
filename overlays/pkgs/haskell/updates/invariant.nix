{ mkDerivation, array, base, bifunctors, comonad, containers
, contravariant, fetchgit, ghc-prim, hspec, hspec-discover
, profunctors, QuickCheck, StateVar, stdenv, stm, tagged
, template-haskell, th-abstraction, transformers
, transformers-compat, unordered-containers
}:
mkDerivation {
  pname = "invariant";
  version = "0.5.3";
  src = fetchgit {
    url = "https://github.com/nfrisby/invariant-functors.git";
    sha256 = "17rklghhvnikwavmps340my4bb5j5vw4hkhjs011kh4vqp78n5ag";
    rev = "1bb7b818e155a609924c842f1c91d9270eb918fe";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    array base bifunctors comonad containers contravariant ghc-prim
    profunctors StateVar stm tagged template-haskell th-abstraction
    transformers transformers-compat unordered-containers
  ];
  testHaskellDepends = [ base hspec QuickCheck template-haskell ];
  testToolDepends = [ hspec-discover ];
  homepage = "https://github.com/nfrisby/invariant-functors";
  description = "Haskell98 invariant functors";
  license = stdenv.lib.licenses.bsd2;
}
