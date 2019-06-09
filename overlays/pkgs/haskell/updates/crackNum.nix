{ mkDerivation, array, base, fetchgit, FloatingHex, stdenv }:
mkDerivation {
  pname = "crackNum";
  version = "2.3";
  src = fetchgit {
    url = "https://github.com/LeventErkok/crackNum.git";
    sha256 = "02cg64rq8xk7x53ziidljyv3gsshdpgbzy7h03r869gj02l7bxwa";
    rev = "54cf70861a921062db762b3c50e933e73446c3b2";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ array base FloatingHex ];
  executableHaskellDepends = [ array base FloatingHex ];
  homepage = "http://github.com/LeventErkok/CrackNum";
  description = "Crack various integer, floating-point data formats";
  license = stdenv.lib.licenses.bsd3;
}
