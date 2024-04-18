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
        packages = with pkgs; {
          audiorelay = callPackage ./derivations/audiorelay.nix {};
          namespaced = callPackage ./derivations/namespaced.nix {};
          ephemeralbrowser = callPackage ./derivations/ephemeralbrowser.nix {};
          ruchrome = callPackage ./derivations/ruchrome.nix {};
          spotify = callPackage ./derivations/spotify.nix { spotify = stable.spotify; };
          microsocks = callPackage ./derivations/microsocks.nix {};
          playit = callPackage ./derivations/playit.nix {};
          lnxrouter = callPackages ./derivations/lnxrouter.nix { useHavaged = true; };
          tdesktop = tdesktop.packages.${system}.default;
        };
        devShells = with pkgs; {
          ykluks = callPackage ./shells/yubikey-luks/default.nix {};
        };
      }
    );
}
