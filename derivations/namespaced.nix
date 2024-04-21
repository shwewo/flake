{ pkgs, lib, stdenv, ... }: 
let
  bin = ../scripts/namespaced;
in stdenv.mkDerivation {
  name = "namespaced";
  version = "1.0.0";

  dontUnpack = true;
  dontBuild = true;
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  installPhase = let 
    binPath = lib.makeBinPath (with pkgs; [
      iproute2
      coreutils
      inetutils
      sysctl
      inotify-tools
      iptables
      procps
      gawk
      curl
    ]);
  in ''
    mkdir -p $out/bin/
    cp ${bin} $out/bin/.namespaced-wrapped
    chmod +x $out/bin/.namespaced-wrapped
    makeWrapper $out/bin/.namespaced-wrapped $out/bin/namespaced --prefix PATH : ${binPath}
  '';

  meta = with lib; {
    description = "Namespace script that uses your default ISP gateway and interface";
    platforms = platforms.linux;
    mainProgram = "namespaced";
  };
}