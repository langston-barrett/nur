{ mkDerivation, base, base-compat, base-orphans, deepseq, fetchgit
, HUnit, QuickCheck, stdenv, tagged, tasty, tasty-hunit
, tasty-quickcheck, time
}:
mkDerivation {
  pname = "time-compat";
  version = "1.9.2.2";
  src = fetchgit {
    url = "https://github.com/phadej/time-compat.git";
    sha256 = "1i79kvixvf5w9hraawjwapnymj2kvrwp8yhncsgpf6bh5c5j760i";
    rev = "b929f56b388454a81f95d3739133a8716791ee73";
    fetchSubmodules = true;
  };
  revision = "1";
  editedCabalFile = "0k8ph4sydaiqp8dav4if6hpiaq8h1xsr93khmdr7a1mmfwdxr64r";
  libraryHaskellDepends = [ base base-orphans deepseq time ];
  testHaskellDepends = [
    base base-compat deepseq HUnit QuickCheck tagged tasty tasty-hunit
    tasty-quickcheck time
  ];
  homepage = "https://github.com/phadej/time-compat";
  description = "Compatibility package for time";
  license = stdenv.lib.licenses.bsd3;
}
