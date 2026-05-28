{
  lib,
  config,
  pkgs,
  flashvim,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./zsh.nix
  ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev"; # obligatoire en UEFI
      efiSupport = true;
      useOSProber = true;
      extraConfig = "GRUB_DISABLE_OS_PROBER=false";
      extraEntries = ''
        menuentry "Arch Linux" {
          insmod part_gpt
          insmod btrfs
          insmod lvm
          search --no-floppy --fs-uuid --set=root A5EC-16FE
          linux /vmlinuz-linux root=/dev/ArchinstallVg/root rootflags=subvol=@ rw quiet
          initrd /intel-ucode.img /initramfs-linux.img
        }
      '';
      minegrub-theme = {
        enable = true;
        splash = "100% Flakes !";
        background = "background_options/1.21.6 - [Chase the Skies].png";
        boot-options-count = 4;
      };
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # secrets
  age = {
    identityPaths = [ "/etc/nixos/age/key" ];
  };

  networking.hostName = "oui"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = [
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.dolphin-plugins
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tristantrad = {
    isNormalUser = true;
    description = "tristantrad";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25518 AAAAC3NzaC1lZDI1NTE5AAAAIEsUW2xv34veXK20S9Mxvmo9jtN8fsOYKx2Amk6HiMCA lolXlangouste@hotmail.com"
    ];

    packages = with pkgs; [
      # for this user only
    ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.direnv.enable = true;
  programs.nh {
    enable = true;
    clean.enable =true;
    clean.extraArgs = "--keep-since 5d --keep 3"
  }

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vesktop
    git
    hyprpaper
    hyprpolkitagent
    libreoffice
    vlc
    prismlauncher
    waybar
    mako
    kitty
    zed-editor
    flashvim.packages."${system}".nvim
    #  wget
  ];

  fonts.packages = with pkgs; [
    font-awesome_4
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  hardware.bluetooth.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
