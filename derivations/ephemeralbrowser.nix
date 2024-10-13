{ pkgs, lib, stdenv, makeWrapper, makeDesktopItem, copyDesktopItems, ... }: 
let
  bin = ../scripts/ephemeralbrowser;
in stdenv.mkDerivation {
  name = "ephemeralbrowser";
  version = "1.0.0";

  dontUnpack = true;
  dontBuild = true;
  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  installPhase = let 
    binPath = lib.makeBinPath (with pkgs; [
      google-chrome
      ungoogled-chromium
      firefox
      zenity
      libnotify
    ]);
  in ''
    mkdir -p $out/bin/ $out/share
    cp ${bin} $out/bin/.ephemeralbrowser-wrapped
    chmod +x $out/bin/.ephemeralbrowser-wrapped
    makeWrapper $out/bin/.ephemeralbrowser-wrapped $out/bin/ephemeralbrowser --prefix PATH : ${binPath}
    copyDesktopItems
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "ephemeralbrowser";
      desktopName = "Ephemeral Browser";
      icon = "browser";
      exec = "ephemeralbrowser";
      type = "Application";
    })

    (makeDesktopItem {
      name = "captive-browser";
      desktopName = "Captive Portal Browser";
      icon = "nix-snowflake";
      exec = "ephemeralbrowser --captive";
      type = "Application";
    })
  ];

  meta = with lib; {
    description = "Firejailed google chrome/ungoogled chromium/firefox";
    platforms = platforms.linux;
    mainProgram = "ephemeralbrowser";
  };
}