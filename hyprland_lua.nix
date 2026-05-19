{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    wlogout
    brightnessctl
    pavucontrol
    pulseaudio
    playerctl
    kdePackages.dolphin
    waybar
    mako
    hyprpaper
    kitty
    hyprpolkitagent
    udiskie
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      env = [
        "XDG_SESSION_TYPE,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      monitor = [
        "eDP-1,highres,0x0,1"
        "HDMI-A-1,highres,1920x0,1"
        ",preferred,auto,1"
      ];

      exec_once = [
        "waybar"
        "mako"
        "hyprpaper"
        "systemctl --user start hyprpolkitagent"
        "udiskie"
      ];

      #animations.enabled = false;

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
      };

      decoration = {
        rounding = 10;
        blur.enabled = false;
        shadow.enabled = false;
      };

      misc = {
        disable_hyprland_logo = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      input = {
        kb_layout = "fr,us";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        numlock_by_default = true;
        sensitivity = 0;
        accel_profile = "flat";
        repeat_delay = 200;
        repeat_rate = 40;

        touchpad = {
          drag_lock = true;
          natural_scroll = true;
        };
      };

      xwayland = {
        force_zero_scaling = true;
      };

      windowrule = [
        "no_initial_focus, xwayland:true"
      ];

      bind = [
        "SUPER + Return, exec, kitty"
        "SUPER + SHIFT + A, killactive,"
        "SUPER + SHIFT, E, exit,"
        "SUPER + SHIFT + Space, togglefloating,"
        "SUPER + D, exec, fuzzel"
        "SUPER + F, fullscreen,"
        "SUPER + P, pseudo,"
        "SUPER + J, togglesplit,"
        "SUPER + SHIFT + N, exec, wlogout"
        "SUPER + E, exec, dolphin"
        "SUPER + C, exec, pavucontrol"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER + SHIFT, H, movewindow, l"
        "SUPER + SHIFT, L, movewindow, r"
        "SUPER + SHIFT, K, movewindow, u"
        "SUPER + SHIFT, J, movewindow, d"

        "SUPER, ampersand, workspace, 1"
        "SUPER, eacute, workspace, 2"
        "SUPER, quotedbl, workspace, 3"
        "SUPER, apostrophe, workspace, 4"
        "SUPER, parenleft, workspace, 5"
        "SUPER, minus, workspace, 6"
        "SUPER, egrave, workspace, 7"
        "SUPER, underscore, workspace, 8"
        "SUPER, ccedilla, workspace, 9"
        "SUPER, agrave, workspace, 10"

        "SUPER + SHIFT, ampersand, movetoworkspacesilent, 1"
        "SUPER + SHIFT, eacute, movetoworkspacesilent, 2"
        "SUPER + SHIFT, quotedbl, movetoworkspacesilent, 3"
        "SUPER + SHIFT, apostrophe, movetoworkspacesilent, 4"
        "SUPER + SHIFT, parenleft, movetoworkspacesilent, 5"
        "SUPER + SHIFT, minus, movetoworkspacesilent, 6"
        "SUPER + SHIFT, egrave, movetoworkspacesilent, 7"
        "SUPER + SHIFT, underscore, movetoworkspacesilent, 8"
        "SUPER + SHIFT, ccedilla, movetoworkspacesilent, 9"
        "SUPER + SHIFT, agrave, movetoworkspacesilent, 10"

        "CTRL + ALT + SHIFT, K, exec, hyprctl kill"

        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER+ALT, mouse:272, resizewindow"
      ];
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      window_padding_width = 15;
    };
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    themeFile = "Catppuccin-Latte";
  };
}
