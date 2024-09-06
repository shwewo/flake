{
  description = "Shwewo's flake with custom programs";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-spotify.url = "github:nixos/nixpkgs?rev=651b4702e27a388f0f18e1b970534162dec09aff";
    flake-utils.url = "github:numtide/flake-utils";
    tdesktop.url = "github:shwewo/telegram-desktop-patched";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-spotify, flake-utils, tdesktop }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
        stable = import nixpkgs-stable { system = system; config.allowUnfree = true; };
        spotify = import nixpkgs-spotify { system = system; config.allowUnfree = true; };
      in {
        packages = with pkgs; {
          audiorelay = callPackage ./derivations/audiorelay.nix {};
          namespaced = callPackage ./derivations/namespaced.nix {};
          ephemeralbrowser = callPackage ./derivations/ephemeralbrowser.nix {};
          ruchrome = callPackage ./derivations/ruchrome.nix {};
          spotify = callPackage ./derivations/spotify.nix { spotify = spotify.spotify; };
          microsocks = callPackage ./derivations/microsocks.nix {};
          playit = callPackage ./derivations/playit.nix {};
          lnxrouter = callPackage ./derivations/lnxrouter.nix { useHaveged = true; };
          spoofdpi = callPackage ./derivations/spoofdpi.nix {};
          tdesktop = tdesktop.packages.${system}.default;
        };
        devShells = with pkgs; {
          ykluks = callPackage ./shells/yubikey-luks/default.nix {};
        };
      }
    );
}
