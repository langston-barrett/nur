{ stdenv
, lib
, fetchFromGitHub
, cmake
, llvm_8
, llvmPackages_8
}:

let pname = "constexpr-everything";
    tob = "trailofbits";
    libclang = llvmPackages_8.libclang.lib;
in llvmPackages_8.stdenv.mkDerivation {
  version = "2020-05-08";
  name = "${pname}";
  nativeBuildInputs = [ llvmPackages_8.clang ];
  buildInputs = [ cmake llvm_8 libclang ];
  LIBCLANG_PATH = "${libclang}/lib";
  src = fetchFromGitHub {
    owner = tob;
    repo = pname;
    rev = "55b97fbae359c159187da26d63a5e65046529ae1";
    sha256 = "0w2x53ij1b5w7ry2drmwihddfb1zs6b0l6fjngavqjgjlil71hni";
  };
  meta = {
    homepage = "https://github.com/${tob}/${pname}";
    license = lib.licenses.asl20;
  };
}
