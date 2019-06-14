{ mkDerivation, base, base-compat, base-orphans, containers
, fetchgit, ghc-boot-th, ghc-prim, hspec, hspec-discover
, QuickCheck, stdenv, tagged, template-haskell, th-abstraction
, transformers, transformers-compat
}:
mkDerivation {
  pname = "deriving-compat";
  version = "0.5.6";
  src = fetchgit {
    url = "https://github.com/haskell-compat/deriving-compat.git";
    sha256 = "14ivyl1lgzxclrlch5i3gifchnrpl4pf053j3f83lm20l0xkkn55";
    rev = "1332ebf46cd250758d05c9a060293fde5b94fd05";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base containers ghc-boot-th ghc-prim template-haskell
    th-abstraction transformers transformers-compat
  ];
  testHaskellDepends = [
    base base-compat base-orphans hspec QuickCheck tagged
    template-haskell transformers transformers-compat
  ];
  testToolDepends = [ hspec-discover ];
  homepage = "https://github.com/haskell-compat/deriving-compat";
  description = "Backports of GHC deriving extensions";
  license = stdenv.lib.licenses.bsd3;
}
