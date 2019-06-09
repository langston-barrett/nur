{ mkDerivation, base, boomerang, fetchgit, HUnit, process, stdenv
, test-framework, test-framework-hunit, text, transformers
, unordered-containers
}:
mkDerivation {
  pname = "itanium-abi";
  version = "0.1.1.1";
  src = fetchgit {
    url = "https://github.com/travitch/itanium-abi.git";
    sha256 = "0jj19pmq0hy9qa1dsiyajpa297z78hm4dnc7qz486w3i3yx8bb11";
    rev = "f4c38607302a2b1489fe88a881d7f2433e26b538";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base boomerang text transformers unordered-containers
  ];
  testHaskellDepends = [
    base HUnit process test-framework test-framework-hunit
  ];
  description = "An implementation of name mangling/demangling for the Itanium ABI";
  license = stdenv.lib.licenses.bsd3;
}
