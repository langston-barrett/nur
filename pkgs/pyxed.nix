{ stdenv
, buildPythonPackage
, fetchFromGitHub
, python3
, xed
}:

let pname = "pyxed";
    version = "89d43cd53d76c17ad47072e8ec867021bc404a14";
in buildPythonPackage rec {
  inherit pname version;
  # src = fetchFromGitHub {
  #   owner = "huku-";
  #   repo = pname;
  #   rev = version;
  #   sha256 = "16b1n5bkln0mk2bcj8pj9wdx2pi9riv7dc88rbhg2b7pdnmlibic";
  # };
  src = ../../pyxed;
  buildInputs = [ python3 xed ];
  XED_CURRENT_KIT_DIR = "${xed}";
  propagatedBuildInputs = [ ];
  meta = {};
}
