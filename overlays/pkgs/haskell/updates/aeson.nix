{ mkDerivation, attoparsec, base, base-compat, base-orphans
, base16-bytestring, bytestring, containers, deepseq, Diff
, directory, dlist, fetchgit, filepath, generic-deriving, ghc-prim
, hashable, hashable-time, integer-logarithms, primitive
, QuickCheck, quickcheck-instances, scientific, stdenv, tagged
, tasty, tasty-golden, tasty-hunit, tasty-quickcheck
, template-haskell, text, th-abstraction, time, time-compat
, time-locale-compat, unordered-containers, uuid-types, vector
}:
mkDerivation {
  pname = "aeson";
  version = "1.4.3.0";
  src = fetchgit {
    url = "https://github.com/bos/aeson.git";
    sha256 = "1753m0rgl4zamh456szvz1n3inc81bsi5f4hav7c0cbmpndg92f2";
    rev = "10681a5dddd0af0ee07e3fdb0367a57238152542";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    attoparsec base base-compat bytestring containers deepseq dlist
    ghc-prim hashable primitive scientific tagged template-haskell text
    th-abstraction time time-compat time-locale-compat
    unordered-containers uuid-types vector
  ];
  testHaskellDepends = [
    attoparsec base base-compat base-orphans base16-bytestring
    bytestring containers Diff directory dlist filepath
    generic-deriving ghc-prim hashable hashable-time integer-logarithms
    QuickCheck quickcheck-instances scientific tagged tasty
    tasty-golden tasty-hunit tasty-quickcheck template-haskell text
    time time-compat unordered-containers uuid-types vector
  ];
  homepage = "https://github.com/bos/aeson";
  description = "Fast JSON parsing and encoding";
  license = stdenv.lib.licenses.bsd3;
}
