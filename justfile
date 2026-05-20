build:
    nix build .#oui.nixosConfigurations.config.system.build.toplevel

switch:
    sudo nixos-rebuild switch --flake .#oui

boot:
    sudo nixos-rebuild boot --flake .#oui

tree:
    nix-tree ./result

update:
    nix flake update --commit-lock-file
