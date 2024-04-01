# My custom flake for some program not packaged in Nix/overrides

### You can run any program via:
```bash
nix run github:shwewo/<program>
```

### If you want to use telegram desktop with patches, please visit this page
### https://github.com/shwewo/telegram-desktop-patched

### To add this to system-wide configuration do this:

`flake.nix`

```nix
inputs = {
  shwewo.url = "github:shwewo/telegram-desktop-patched";
  # your other inputs
};

outputs = inputs @ { self, nixpkgs, ... }: {
  nixosConfigurations.<HOSTNAME> = stable.lib.nixosSystem {
    system = "x86_64-linux"; 
    specialArgs = { inherit inputs }; # this line is important
    modules = [ ./configuration.nix ];
  };
}; 
```
### And then you can just add this:

`configuration.nix`
```nix
environment.systemPackages = with pkgs; [
  inputs.shwewo.packages.${pkgs.system}.<program>
  # your other programs
]
```