{
  description = "Shwewo's flake with custom programs";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    tdesktop.url = "github:shwewo/telegram-desktop-patched";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, flake-utils, tdesktop }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
        stable = import nixpkgs-stable { system = system; config.allowUnfree = true; };
      in {
        packages = {
          audiorelay = pkgs.callPackage ./derivations/audiorelay.nix {};
          namespaced = pkgs.callPackage ./derivations/namespaced.nix {};
          ephemeralbrowser = pkgs.callPackage ./derivations/ephemeralbrowser.nix {};
          ruchrome = pkgs.callPackage ./derivations/ruchrome.nix {};
          spotify = pkgs.callPackage ./derivations/spotify.nix { spotify = stable.spotify; };
          microsocks = pkgs.callPackage ./derivations/microsocks.nix {};
          playit = pkgs.callPackage ./derivations/playit.nix {};
          tdesktop = tdesktop.packages.${system}.default;
        };
      }
    );
}
