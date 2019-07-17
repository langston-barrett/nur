{ stdenv
, fetchFromGitHub
, cmake
, llvmPackages
}:

stdenv.mkDerivation {
  name = "constexpr-everything";
  src = fetchFromGitHub {
    owner = "trailofbits";
    repo  = "constexpr-everything";
    rev = "71f539dc805e581076cb50d146bf8fedbcfa7dff";
    sha256 = "0r27y7sxy95wj58d0cilmgiscgrkqcqbb21iq9n2psm0mhikbcy5";
  };
  nativeBuildInputs = [ cmake ];
  buildInputs = [ llvmPackages.libclang llvmPackages.llvm ];
  cmakeFlags  = ["-DCMAKE_CXX_FLAGS=-isystem=${llvmPackages.libclang}"];
  meta = {
    description = "A libclang based project to automatically rewrite as much code as possible to be evaluated in constexpr contexts";
    homepage    = "https://github.com/trailofbits/constexpr-everything";
    license     = stdenv.lib.licenses.apache2;
    platforms   = stdenv.lib.platforms.unix;
  };
}
