{ stdenv
, fetchFromGitHub
, mbuild
, python3
}:

let pname = "xed";
    version = "11.2.0";
    py = python3.withPackages (_: [mbuild]);
in stdenv.mkDerivation {
  inherit version;
  name = "${pname}-${version}";
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = pname;
    rev = version;
    sha256 = "1jffayski2gpd54vaska7fmiwnnia8v3cka4nfyzjgl8xsky9v2s";
  };

  buildInputs = [ py ];

  buildPhase = ''
    ${py}/bin/python mfile.py --shared install
  '';

  installPhase = ''
    mkdir $out
    mv ./kits/xed-install-base-*/* $out
  '';

  meta = with stdenv.lib; {
    description = "x86 encoder decoder";
    homepage = "https://github.com/intelxed/${pname}";

    license = licenses.asl20;
    maintainers = [ maintainers.siddharthist ];
    platforms = platforms.unix;
  };
}
