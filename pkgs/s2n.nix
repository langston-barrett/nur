{ fetchgit
, stdenv

, bash
, clang_38
, gnumake
, llvm_38
, openssl_1_1
, saw-script
, yices
, z3
}:

stdenv.mkDerivation rec {
  name = "s2n-${version}";
  version = "update-saw-version-latest";

  src = fetchgit {
    url = "https://github.com/GaloisInc/s2n";
    rev = "48c307194e08fc7446f3954b49e6a1cbe1de4bfc";
    sha256 = "0jl8jv87dn4i1cnazwrz0fr6akr12427nlsrrnfh983ha4way8fb";
    fetchSubmodules = false;
  };

  depsBuildBuild = [
    saw-script
    gnumake
    clang_38  # specifically requires clang-3.8
    llvm_38
    z3
    yices
    openssl_1_1
  ];

  phases = [ "buildPhase" ];

  buildPhase = ''
    echo creating out $out
    mkdir $out
    cp -r $src/* $out

    cd $out

    # Ensure new directories and files can be created (default dir prots are r_wr_wr_w)
    chmod -R oga+rwx tests/saw

    # Run the verification portion, ensuring that the imported clang and llvm are accessible.
    cd $out/tests/saw;
    echo "Running ${gnumake}/bin/make SHELL=${bash}/bin/bash"
    CLANG=$BUILD_CC LLVMLINK=llvm-link CFLAGS_LLVM="$NIX_BUILD_CFLAGS_COMPILE" ${gnumake}/bin/make SHELL=${bash}/bin/bash bitcode/all_llvm.bc
    CLANG=$BUILD_CC LLVMLINK=llvm-link CFLAGS_LLVM="$NIX_BUILD_CFLAGS_COMPILE" ${gnumake}/bin/make SHELL=${bash}/bin/bash failure_tests/sha_bad_magic_mod.log
    # CLANG=$BUILD_CC LLVMLINK=llvm-link CFLAGS_LLVM="$NIX_BUILD_CFLAGS_COMPILE" ${gnumake}/bin/make SHELL=${bash}/bin/bash
    # CLANG=$BUILD_CC LLVMLINK=llvm-link CFLAGS_LLVM="$NIX_BUILD_CFLAGS_COMPILE" ${gnumake}/bin/make sike SHELL=${bash}/bin/bash
  '';

  meta = {
    description = "Latest master sources for the s2n repository.";
    platforms = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [kquick];

  };
}
