{ mkDerivation, base, config-value, containers, fetchgit, free
, kan-extensions, pretty, semigroupoids, stdenv, text, transformers
}:
mkDerivation {
  pname = "config-schema";
  version = "1.1.0.0";
  src = fetchgit {
    url = "https://github.com/glguy/config-schema.git";
    sha256 = "146lxaaahyma192180k294aqsc0zwglls0i3z271hijiy0qnjqrf";
    rev = "2950ac74f66f0e8e55a75e7194da9109993a61ee";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base config-value containers free kan-extensions pretty
    semigroupoids text transformers
  ];
  testHaskellDepends = [ base config-value text ];
  homepage = "https://github.com/glguy/config-schema";
  description = "Schema definitions for the config-value package";
  license = stdenv.lib.licenses.isc;
}
