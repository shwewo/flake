{ pkgs, lib, stdenv, copyDesktopItems, fetchurl, ... }:

let
  chrome = pkgs.writeScriptBin "google-chrome-russia" ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.coreutils}/bin/mkdir -p $HOME/.google-chrome-russia/.pki/nssdb/
    ${pkgs.nssTools}/bin/certutil -d sql:$HOME/.google-chrome-russia/.pki/nssdb -A -t "C,," -n "Russian Trusted Root" -i ${builtins.fetchurl {
      url = "https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt";
      sha256 = "sha256:0135zid0166n0rwymb38kd5zrd117nfcs6pqq2y2brg8lvz46slk";
    }}
    ${pkgs.nssTools}/bin/certutil -d sql:$HOME/.google-chrome-russia/.pki/nssdb -A -t "C,," -n "Russian Trusted Sub CA" -i ${builtins.fetchurl {
      url = "https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.crt";
      sha256 = "sha256:19jffjrawgbpdlivdvpzy7kcqbyl115rixs86vpjjkvp6sgmibph";
    }}  
    firejail --blacklist="/var/run/nscd" --ignore="include whitelist-run-common.inc" --private=$HOME/.google-chrome-russia --net=$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gawk}/bin/awk '{print $5; exit}') --dns=77.88.8.1 --profile=google-chrome ${pkgs.google-chrome}/bin/google-chrome-stable --no-first-run -no-default-browser-check --class=google-chrome-russia https://ifconfig.me
  '';
in stdenv.mkDerivation {
  name = "google-chrome-russia";
  version = "1.0.0";
  
  phases = [ "installPhase"];

  nativeBuildInputs = [
    copyDesktopItems
  ];
   
  installPhase = ''
    mkdir -p $out/bin/ $out/share
    cp ${chrome}/bin/google-chrome-russia $out/bin/google-chrome-russia
    copyDesktopItems
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "google-chrome-russia";
      desktopName = "Google Chrome Russia";
      genericName = "Web Browser";
      icon = fetchurl {
        url = "https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/df803da7f0475cf0549e6c13ad916b980515a7cb/Papirus/64x64/apps/google-chrome-unstable.svg";
        sha256 = "sha256-yphg/VFqJAJPB77E4MV7ioG0fM7yAaujDOhg5tFlHto=";
      };
      exec = "google-chrome-russia";
    })
  ];

  meta = with lib; {
    description = "Firejailed google chrome with russian certificates";
    platforms = platforms.linux;
    mainProgram = "google-chrome-russia";
  };
}