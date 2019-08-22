{ stdenv
, sbt
, jdk
, jre
, fetchFromGitHub
, makeWrapper
}:

let pname = "scalastyle";
    version = "v1.0.0";

in stdenv.mkDerivation {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "scalastyle";
    repo = "scalastyle";
    rev = "v1.0.0";
    sha256 = "1ffahsiwwg1008dd23m5450kd7z7i3jfvlz4j3fhb14wd18r21zw";
  };

  buildInputs = [ sbt jdk makeWrapper ];

  buildPhase = ''
    sbt
  '';

  installPhase =
    ''
      mkdir -p $out/bin
      makeWrapper ${jre}/bin/java $out/bin/foo \
        --add-flags "-cp $out/share/java/foo.jar org.foo.Main"
    '';
}


