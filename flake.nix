{
  description = "Shwewo flake with custom programs";
  
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    tdesktop.url = "github:nixos/shwewo/telegram-desktop-patched";
  };

  outputs = { self, nixpkgs, flake-utils, inputs }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = {
          audiorelay = pkgs.callPackage ./derivations/audiorelay.nix {};
          namespaced = pkgs.callPackage ./derivations/namespaced.nix {};
          ephemeralbrowser = pkgs.callPackage ./derivations/ephemeralbrowser {};
          spotify = pkgs.callPackage ./derivations/spotify.nix {};
          microsocks = pkgs.callPackage ./derivations/microsocks.nix {};
          playit = pkgs.callPackage ./derivations/playit.nix {};
          tdesktop = inputs.tdesktop.packages.${pkgs.system}.default;
        };
      }
    );
}
