{
  config, 
  lib, 
  pkgs, 
  ...
}:
{
  imports = [
     ./hyprland.nix
  ];

  home.packages = with pkgs; [
    waybar
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
    waybar.enable = true;
    waybar.settings.main = {
      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory" 
        "temperature"
        "backlight" 
        "sway/language" 
        "battery" 
        "battery#bat2" 
        "clock" 
        "tray"
      ];
      module-center = [
        "sway/window"
      ];
      module-left = [
        "hyprland/workspaces" 
	"custom/media"
      ];
      position = "bottom";
      height = 30;

      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
            "activated" = ""; 
            "deactivated" = "";
        };
      };

      "tray" = {
        "spacing" = 10;
      };

      "clock" = {
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };

      "cpu" = {
        "format" = "{usage}% ";
        "tooltip" = false;
      };

      "memory" = {
        "format" = "{}% ";
      };

      "temperature" = {
        "critical-threshold" = 80;
        "format" = "{temperatureC}°C {icon}";
        "format-icons" = ["" "" ""];
      };

      "backlight" = {
        "format" = "{percent}% {icon}";
        "format-icons" = ["" "" "" "" "" "" "" "" ""];
      };

      "battery" = {
        "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
        };
        "format" = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        "format-icons" = ["" "" "" "" ""];
	"interval" = 3;
      };
      
      "network" = {
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        # "on-click" = "nm-connection-editor";
      };

      "pulseaudio" = {
        # "scroll-step": 1, // %, can be a float
        "format" = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
        "on-click" = "pavucontrol";
      };
    };
  };
}
