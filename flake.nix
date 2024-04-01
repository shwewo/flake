{
  description = "Shwewo's flake with custom programs";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    tdesktop.url = "github:shwewo/telegram-desktop-patched";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, stable, tdesktop }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = {
          audiorelay = pkgs.callPackage ./derivations/audiorelay.nix {};
          namespaced = pkgs.callPackage ./derivations/namespaced.nix {};
          ephemeralbrowser = pkgs.callPackage ./derivations/ephemeralbrowser.nix {};
          spotify = pkgs.callPackage ./derivations/spotify.nix { spotify = inputs.stable.legacyPackages.${system}.spotify; };
          microsocks = pkgs.callPackage ./derivations/microsocks.nix {};
          playit = pkgs.callPackage ./derivations/playit.nix {};
          tdesktop = inputs.tdesktop.packages.${system}.default;
        };
      }
    );
}
