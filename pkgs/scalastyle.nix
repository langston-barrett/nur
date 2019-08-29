{ stdenv
, sbt
, jdk
, jre
, fetchurl
, makeWrapper
, defaultConfigFile ? true
}:

let pname = "scalastyle";
    version = "v1.0.0";

in stdenv.mkDerivation {
  name = "${pname}-${version}";
  src = ./.;
  buildInputs = [ makeWrapper ];
  installPhase =
    let jar = fetchurl {
          url = https://repo1.maven.org/maven2/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0-batch.jar;
          sha256 = "1jzdb9hmvmhz3niivm51car74l8f3naspz4b3s6g400dpsbzvnp9";
        };
        config = fetchurl {
          url = http://www.scalastyle.org/scalastyle_config.xml;
          sha256 = "1rd2jyy4y01girbqisjzw7w79ckzl9z6mgql4gc15ry3vmmryyz3";
        };
    in ''
      mkdir -p $out/bin
      mkdir -p $out/share/java
      cp ${jar} $out/share/java/${pname}.jar
      makeWrapper ${jre}/bin/java $out/bin/scalastyle \
        --set JAVA_HOME "${jre}" \
        --add-flags "-cp $out/share/java/${pname}.jar org.scalastyle.Main" \
        ${if defaultConfigFile then "--add-flags '--config ${config}'" else ""}
    '';
}
