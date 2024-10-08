{ pkgs, stdenv }:

stdenv.mkDerivation {
  pname = "byedpi";
  version = "0.14.1";

  dontBuild = true;
  sourceRoot = ".";

  src = pkgs.fetchurl {
    url = "https://github.com/hufrea/byedpi/releases/download/v0.14.1/byedpi-14.1-x86_64.tar.gz";
    hash = "sha256-CUhfoFFr42pMxQSCGIBR8S1IYK2ReOAi4rrvNuTNfPY=";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp ./ciadpi-x86_64 $out/bin/byedpi
  '';
}
