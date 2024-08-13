{ pkgs, stdenv }:

stdenv.mkDerivation {
  pname = "linux-router";
  version = "0.7.3";

  dontBuild = true;

  src = pkgs.fetchurl {
    url = "https://github.com/xvzc/SpoofDPI/releases/download/v0.10.6/spoof-dpi-linux-amd64.tar.gz";
    hash = "";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp $src/spoof-dpi $out/bin/
  '';
}
