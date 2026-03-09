{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/services.nix
    # ./modules/vm.nix
  ];

  # TODO Nvidia drivers 470xx setup

  # =========================================================================
  # NIX SETTINGS
  # =========================================================================

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

  # =========================================================================
  # BOOT
  # =========================================================================

  boot.loader = {
    systemd-boot = {
      enable             = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # =========================================================================
  # NETWORKING
  # =========================================================================

  networking = {
    hostName              = "nixos";
    networkmanager.enable = true;
  };

  # =========================================================================
  # LOCALE & TIME
  # =========================================================================

  time.timeZone = "Asia/Karachi";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS        = "ur_PK";
      LC_IDENTIFICATION = "ur_PK";
      LC_MEASUREMENT    = "ur_PK";
      LC_MONETARY       = "ur_PK";
      LC_NAME           = "ur_PK";
      LC_NUMERIC        = "ur_PK";
      LC_PAPER          = "ur_PK";
      LC_TELEPHONE      = "ur_PK";
      LC_TIME           = "ur_PK";
    };
  };

  # =========================================================================
  # USERS
  # =========================================================================

  users = {
    defaultUserShell = pkgs.zsh;
    users.hxt = {
      isNormalUser = true;
      description  = "Hasnat Safdar";
      extraGroups  = [ "networkmanager" "wheel" "docker" ];
    };
  };

  # =========================================================================
  # FONTS
  # =========================================================================

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    poppins
    inter
  ];

  # =========================================================================
  # AUDIO
  # =========================================================================

  security.rtkit.enable = true;

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    jack.enable       = true;
  };

  # =========================================================================
  # DISPLAY & WINDOW MANAGERS
  # =========================================================================

  services.displayManager.ly.enable = true;

  services.xserver = {
    enable             = true;
    autoRepeatDelay    = 200;
    autoRepeatInterval = 35;

    xkb = {
      layout  = "us";
      variant = "";
    };

    windowManager = {
      xmonad = {
        enable                 = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [
          hpkgs.xmonad
          hpkgs.xmonad-extras
          hpkgs.xmonad-contrib
        ];
      };

      qtile = {
        enable        = true;
        extraPackages = python3Packages: with python3Packages; [
          qtile-extras
        ];
      };
    };
  };

  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable       = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # =========================================================================
  # SHELL
  # =========================================================================

  programs.zsh.enable = true;

  environment.shells = [
    pkgs.zsh
    pkgs.nushell
  ];

  # =========================================================================
  # PROGRAMS
  # =========================================================================

  # Build tools & system libraries — kept here as they are system-level deps
  environment.systemPackages = with pkgs; [
    cmake
    gnumake
    gcc
    pkg-config
    fontconfig
    libX11
    libXft
    libXinerama
    freetype
    harfbuzz
    brightnessctl
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
  };

  programs.gnupg.agent = {
    enable          = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.nix-ld = {
    enable    = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
    ];
  };

  programs.nh = {
    enable = true;
    flake  = "/home/hxt/nix";
    clean = {
      enable    = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  # =========================================================================
  # VIRTUALISATION
  # =========================================================================

  virtualisation.docker = {
    enable   = true;
    rootless = {
      enable            = false;
      setSocketVariable = true;
    };
  };
}
