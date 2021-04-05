with (import <nixpkgs> { });

stdenv.mkDerivation rec {
  pname = "adr-tools";
  version = "3.0.0";

  src = fetchurl {
    url = "https://github.com/npryce/adr-tools/archive/${version}.tar.gz";
    sha256 = "9490f31a457c253c4113313ed6352efcbf8f924970a309a08488833b9c325d7c";
  };

  buildInputs = [ getopt bashInteractive ];

  patches = [ ./fix-paths.patch ];
  postPatch = ''
    patchShebangs src/*
    patchShebangs approve
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp src/*adr* $out/bin
  '';
}
