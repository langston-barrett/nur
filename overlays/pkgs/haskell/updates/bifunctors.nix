{ mkDerivation, base, base-orphans, comonad, containers, fetchgit
, hspec, hspec-discover, QuickCheck, stdenv, tagged
, template-haskell, th-abstraction, transformers
, transformers-compat
}:
mkDerivation {
  pname = "bifunctors";
  version = "5.5.4";
  src = fetchgit {
    url = "https://github.com/ekmett/bifunctors.git";
    sha256 = "1axji3c2bf93a44vzkm0pwagl4pw6jdgljkx7xs6hq3yl7wbq3j7";
    rev = "357b346799792f7267f0844d76546837e026370c";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base base-orphans comonad containers tagged template-haskell
    th-abstraction transformers
  ];
  testHaskellDepends = [
    base hspec QuickCheck template-haskell transformers
    transformers-compat
  ];
  testToolDepends = [ hspec-discover ];
  homepage = "http://github.com/ekmett/bifunctors/";
  description = "Bifunctors";
  license = stdenv.lib.licenses.bsd3;
}
