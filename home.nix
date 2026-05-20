{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hypr/hyprland.nix
    ./hypr/waybar.nix
  ];

  home.stateVersion = "25.11";

  programs = {
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "~/.ssh/tristantrad_key";
        };
      };
    };
  };
}
