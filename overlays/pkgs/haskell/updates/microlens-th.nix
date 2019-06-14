{ mkDerivation, base, containers, fetchgit, microlens, stdenv
, template-haskell, th-abstraction, transformers
}:
mkDerivation {
  pname = "microlens-th";
  version = "0.4.2.4";
  src = fetchgit {
    url = "https://github.com/monadfix/microlens";
    sha256 = "02gpghadx08m576lijgfy3bd4j54w8q1d4bkakl32pv2qizjngr4";
    rev = "dd911f239968a0e6cb57e6e014476bfa85801be0";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/microlens-th; echo source root reset to $sourceRoot";
  libraryHaskellDepends = [
    base containers microlens template-haskell th-abstraction
    transformers
  ];
  testHaskellDepends = [ base microlens ];
  homepage = "http://github.com/monadfix/microlens";
  description = "Automatic generation of record lenses for microlens";
  license = stdenv.lib.licenses.bsd3;
}
