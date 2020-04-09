{ stdenv
, fetchFromBitbucket
, cmake
, openjdk
}:

stdenv.mkDerivation {
  name = "Fact++";
  src = fetchFromBitbucket {
    owner = "dtsarkov";
    repo = "factplusplus";
    rev = "650a50ce78a2f9c7fd609a2ee82b72b6e25f34ee";
    sha256 = "0aqappfdwyqxwnxvzf1b3cxpw42rnkiagabivinxhjny0vhbcpb3";
  };
  buildInputs = [ cmake openjdk ];
  installPhase = ''
    ls -alh
    ls FaCT++ -alh
    mkdir -p $out/bin
    mv FaCT++/FaCT++ $out/bin
  '';
}
