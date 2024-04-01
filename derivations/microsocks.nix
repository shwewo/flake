{ pkgs, lib, stdenv, fetchFromGitHub }: 

stdenv.mkDerivation {
  pname = "microsocks";
  version = "1.0.4";
  
  src = fetchFromGitHub {
    owner = "rofl0r";
    repo = "microsocks";
    rev = "v1.0.4";
    sha256 = "sha256-cB2XMWjoZ1zLAmAfl/nqjdOyBDKZ+xtlEmqsZxjnFn0=";
  };

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin/
    cp ./microsocks $out/bin/
  '';

  meta = with lib; {
    description = "Tiny socks5 server";
    homepage = "https://github.com/rofl0r/microsocks";
    license = license.mit;
    platforms = platforms.linux;
    mainProgram = "microsocks";
  };
}