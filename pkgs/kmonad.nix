{ mkDerivation, base, bytestring, cereal, containers, exceptions
, hashable, lens, megaparsec, monad-logger, mtl
, optparse-applicative, process, stdenv, text, time, unagi-chan
, unix, unliftio, unordered-containers
, fetchFromGitHub
}:
mkDerivation {
  pname = "kmonad";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "david-janssen";
    repo = "kmonad";
    rev = "0.3.0";
    sha256 = "1g40nkpldih6h1rlxjx5yf9iavr3qs1f2b6j0gd8135p5hkg8d8n";
  }; 
  isLibrary = false;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring cereal containers exceptions hashable lens
    megaparsec monad-logger mtl optparse-applicative process text time
    unagi-chan unix unliftio unordered-containers
  ];
  executableHaskellDepends = [ base ];
  description = "Advanced keyboard remapping utility";
  license = stdenv.lib.licenses.mit;
}
