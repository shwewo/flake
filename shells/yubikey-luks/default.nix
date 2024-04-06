{ pkgs, lib, stdenv, fetchurl, ... }:
let
  pbkdf2Sha512 = stdenv.mkDerivation rec {
    name = "pbkdf2-sha512";
    version = "latest";
    buildInputs = with pkgs; [ openssl ];
      
    src = fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/nixos/modules/system/boot/pbkdf2-sha512.c";
      sha256 = "0ky414spzpndiifk7wca3q3l9gzs1ksn763dmy48xdn3q0i75s9r";
    };

    unpackPhase = ":";
    buildPhase = "cc -O3 -I${pkgs.openssl.dev}/include -L${pkgs.openssl.out}/lib ${src} -o pbkdf2-sha512 -lcrypto";
    installPhase = ''
      mkdir -p $out/bin
      install -m755 pbkdf2-sha512 $out/bin/pbkdf2-sha512
    '';
  };
  rbtohex = pkgs.writeScriptBin "rbtohex" ''( od -An -vtx1 | tr -d ' \n' )'';
  hextorb = pkgs.writeScriptBin "hextorb" ''( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf )'';
  yk-luks-open = pkgs.writeScriptBin "yk-luks-open" "${./yk-luks-open} $@";
  yk-luks-install = pkgs.writeScriptBin "yk-luks-install" "${./yk-luks-install} $@";
in pkgs.mkShell {
  name = "yubikey-luks-setup";
  buildInputs = with pkgs; [
    cryptsetup
    openssl
    parted
    yubikey-personalization

    pbkdf2Sha512
    rbtohex
    hextorb
    yk-luks-open
    yk-luks-install
  ];
}