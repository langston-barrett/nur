{ lib
, python
, fetchFromGitHub
, buildPythonPackage
}:
let pname = "mbuild";
    version = "2020-04-27";
in buildPythonPackage {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "mbuild";
    rev = "5304b94361fccd830c0e2417535a866b79c1c297";
    sha256 = "0r3avc3035aklqxcnc14rlmmwpj3jp09vbcbwynhvvmcp8srl7dl";
  };
  meta = with lib; {
    description = "x86 encoder decoder";
    homepage = "https://github.com/intelxed/${pname}";
    license = licenses.asl20;
    maintainers = [ maintainers.siddharthist ];
    platforms = platforms.unix;
  };
}
