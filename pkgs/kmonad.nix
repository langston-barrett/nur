{ fetchFromGitHub, mkDerivation, base, cereal, hspec, hspec-discover, lens, lib
, megaparsec, mtl, optparse-applicative, resourcet, rio
, template-haskell, time, unix, unliftio
}:
mkDerivation {
  pname = "kmonad";
  version = "0.4.1";
  doHaddock = false;
  src = fetchFromGitHub {
    owner = "kmonad";
    repo = "kmonad";
    rev = "0.4.1";
    sha256 = "TXpyXK+2Fa5mhl6T9PVtgRDdsuTEkBk86Pbn3T9A6OY=";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base cereal lens megaparsec mtl optparse-applicative resourcet rio
    template-haskell time unix unliftio
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base hspec ];
  testToolDepends = [ hspec-discover ];
  description = "Advanced keyboard remapping utility";
  license = lib.licenses.mit;
}
