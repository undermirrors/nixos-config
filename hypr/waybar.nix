{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
    settings.main = {
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "sway/language"
        "battery"
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
        "format-icons" = [ "" ];
      };

      "backlight" = {
        "format" = "{percent}% {icon}";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
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
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
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
          "default" = [
            ""
            ""
            ""
          ];
        };
        "on-click" = "pavucontrol";
      };
    };
  };
}
