{ stdenv
, fetchFromGitHub
, sqlite
}:

let version = "20190905";
in stdenv.mkDerivation {
  inherit version;
  name = "worgle-${version}";

  buildInputs = [sqlite];

  preInstall = ''
    mkdir -p $out/bin
    sed -i "s|/usr/local/bin|$out/bin|" Makefile
  '';

  src = fetchFromGitHub {
    owner = "OrgTangle";
    repo = "Worgle";
    rev = "de2c03feac68cd2e96431a423202137062768919";
    sha256 = "0q5j0jzws92c6va0lkzh6b4ndl850n0anl5knwpbj8qrpf3qf11p";
  };

  enableParallelBuilding = true;

  meta = {
    homepage    = "https://github.com/OrgTangle/Worgle";
    platforms   = stdenv.lib.platforms.unix;
    license     = stdenv.lib.licenses.publicDomain;
  };
}
