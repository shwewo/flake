{
  description = "Shwewo's flake with custom programs";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
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
