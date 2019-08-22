{ stdenv
, sbt
, jdk
, jre
, fetchurl
, makeWrapper
}:

let pname = "scalastyle";
    version = "v1.0.0";

in stdenv.mkDerivation {
  name = "${pname}-${version}";

  # src = fetchFromGitHub {
  #   owner = "scalastyle";
  #   repo = "scalastyle";
  #   rev = "v1.0.0";
  #   sha256 = "1ffahsiwwg1008dd23m5450kd7z7i3jfvlz4j3fhb14wd18r21zw";
  # };

  src = ./.;

  buildInputs = [ sbt jdk makeWrapper ];

  buildPhase = ''
    # sbt "set offline := true"
  '';

  installPhase =
    let jar = fetchurl {
          url = https://repo1.maven.org/maven2/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0.jar;
          sha256 = "1jbpyij38zl2d0igywsizd0kbc9291prmnxn07cx71nh50vmvvny";
        };
    in ''
      mkdir -p $out/bin
      mkdir -p $out/share/java
      cp ${jar} $out/share/java/${pname}.jar
      makeWrapper ${jre}/bin/java $out/bin/scalastyle \
        --set JAVA_HOME "${jre}" \
        --add-flags "-cp $out/share/java/${pname}.jar org.scalastyle.Main"
    '';
    # mkdir -p $out/bin
    # makeWrapper ${jre}/bin/java $out/bin/foo \
    #   --add-flags "-cp $out/share/java/foo.jar org.foo.Main"
}


