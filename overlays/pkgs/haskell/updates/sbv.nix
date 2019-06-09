{ mkDerivation, array, async, base, bytestring, containers
, crackNum, deepseq, directory, doctest, fetchgit, filepath
, generic-deriving, ghc, Glob, hlint, mtl, pretty, process
, QuickCheck, random, stdenv, syb, tasty, tasty-golden, tasty-hunit
, tasty-quickcheck, template-haskell, time, transformers, z3
}:
mkDerivation {
  pname = "sbv";
  version = "8.3";
  src = fetchgit {
    url = "https://github.com/LeventErkok/sbv.git";
    sha256 = "0rmp3kdhbj5y4my7062bgaxdr5wbw5h791axkszmy43jigxnbkd4";
    rev = "96757aab1fe1fd3131166ef19e5e018ee7dc8890";
    fetchSubmodules = true;
  };
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    array async base containers crackNum deepseq directory filepath
    generic-deriving ghc mtl pretty process QuickCheck random syb
    template-haskell time transformers
  ];
  testHaskellDepends = [
    base bytestring containers crackNum directory doctest filepath Glob
    hlint mtl QuickCheck random syb tasty tasty-golden tasty-hunit
    tasty-quickcheck template-haskell
  ];
  testSystemDepends = [ z3 ];
  homepage = "http://leventerkok.github.com/sbv/";
  description = "SMT Based Verification: Symbolic Haskell theorem prover using SMT solving";
  license = stdenv.lib.licenses.bsd3;
}
