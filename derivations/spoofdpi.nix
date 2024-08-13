{ pkgs, stdenv }:

stdenv.mkDerivation {
  pname = "spoof-dpi";
  version = "0.7.3";

  dontBuild = true;
  sourceRoot = ".";

  src = pkgs.fetchurl {
    url = "https://github.com/xvzc/SpoofDPI/releases/download/v0.10.6/spoof-dpi-linux-amd64.tar.gz";
    hash = "sha256-5I0no/w90d56DXgKbakWdNymmkpBYUy5SZnakKgFWSo=";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp ./spoof-dpi $out/bin/
  '';
}
