{ stdenv
, buildPythonPackage
, fetchPypi
, pytest
}:

let pname = "orgparse";
    version = "0.1.3";
in buildPythonPackage rec {
  inherit pname version;
  src = fetchPypi {
    inherit pname version;
    sha256 = "0yxk1l9ygk3v6f4170213p23g8csjx8h9ygh95h7cmi2mj5ihrzc";
  };
  buildInputs = [ ];
  checkInputs = [ pytest ];
  propagatedBuildInputs = [ ];
}
