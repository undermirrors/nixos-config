# build nixos configuration
build:
    nix build .#oui.nixosConfigurations.config.system.build.toplevel

# switch nixos to the new configuration now
switch:
    sudo nixos-rebuild switch --flake .#oui

# swich nixos now, but also bootloader
SWB:
    sudo nixos-rebuild switch --flake .#oui --install-bootloader

# switch nixos config in next boot
boot:
    sudo nixos-rebuild boot --flake .#oui

# display nix tree
tree:
    nix-tree ./result

# update system
update:
    nix flake update --commit-lock-file

# edit secret configuration (requires root). Available secret_name : networks
edit_secret SECRET_NAME:
    cd secrets && sudo EDITOR=nvim agenix -i /etc/nixos/age/key -e oui/{{SECRET_NAME}}.age && cd ..

# Quick Config Commit for nixos
qcc COMMIT_MESSAGE:
    git add * && git commit -m "{{COMMIT_MESSAGE}}"
