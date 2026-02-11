{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel (stable default – safer than latest)
  boot.kernelPackages = pkgs.linuxPackages;

  # Hostname & networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Time & locale
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio (PipeWire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Power management
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # X11 + XMonad
  services.xserver = {
    enable = true;

    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    displayManager = {
      ly.enable = true;
      defaultSession = "none+xmonad";
      sessionCommands = ''
        xwallpaper --zoom ~/Pictures/wave.png
      '';
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      extraPackages = hpkgs: [
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
      ];
    };
  };

  # Compositor
  services.picom.enable = true;

  # OpenGL (important for X + picom)
  hardware.graphics.enable = true;

  # User
  users.users.hxt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Programs
  programs.firefox.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    dmenu
    haskell-language-server
    xwallpaper
  ];

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    fontconfig.enable = true;
  };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ⚠️ DO NOT change after install
  system.stateVersion = "25.11";
}
