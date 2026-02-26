{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      # ./vm.nix
    ];

  users.users.hxt = {
    isNormalUser = true;
    description = "Hasnat Safdar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      alacritty
      brave
      obs-studio
      ffmpeg
      yt-dlp
      obsidian
      bat
      kanata
      emacs
      mpd
      mpc
      fastfetch btop nitch
      thunar
      lxappearance
      gopass
      xmobar
      tealdeer
      ddgr w3m
      haskell-language-server
      dmenu
      polybar
      rofi
      rofi-emoji
      kitty
      picom
      mpv
      clock-rs
      zathura
      yazi lf
      imagemagick
      eza
      ueberzugpp
      stow
      aria2
      cava
      rmpc
      dunst libnotify
      tmux
      fzf
      lazygit
      zoxide
      xwallpaper nitrogen
      hyprpaper swww
      hugo
      buku
    ];
  };

  environment.systemPackages = with pkgs; [
    coreutils
    nix-output-monitor
    vim
    wget
    xclip
    ripgrep
    fd
    bc
    pulseaudio
    brightnessctl
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/hxt/Music";
    network.listenAddress = "127.0.0.1";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/user/my-nixos-config"; # sets NH_OS_FLAKE variable for you
  };

  services = {
  # picom.enable = true;
  displayManager = {
    ly.enable = true;
  };
  xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [
          hpkgs.xmonad
          hpkgs.xmonad-extras
          hpkgs.xmonad-contrib
       ];
     };
    };
   };
  };

  services.desktopManager.gnome.enable = true;

  services.flatpak.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

    programs.zsh = {
	enable = true;
    };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs.neovim.enable = true;
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;

  programs.git.enable = true;

  programs.git.config = {
    user.name = "hasnatsafdar";
    user.email = "hasnat.professional@gmail.com";
    };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
	(defsrc
         caps a s d f j k l ; lalt ralt
        )
        (defvar
         tap-time 150
         hold-time 200
        )
        
        (defalias
         a (multi f24 (tap-hold $tap-time $hold-time a lmet))
         s (multi f24 (tap-hold $tap-time $hold-time s lalt))
         d (multi f24 (tap-hold $tap-time $hold-time d lsft))
         f (multi f24 (tap-hold $tap-time $hold-time f lctl))
         j (multi f24 (tap-hold $tap-time $hold-time j rctl))
         k (multi f24 (tap-hold $tap-time $hold-time k rsft))
         l (multi f24 (tap-hold $tap-time $hold-time l ralt))
         ; (multi f24 (tap-hold $tap-time $hold-time ; rmet))
         lalt (tap-hold $tap-time $hold-time bspc lalt)
         ralt (tap-hold $tap-time $hold-time ret ralt)
        )
        
        (deflayer base
         esc @a @s @d @f @j @k @l @; @lalt @ralt
        )
        '';
      };
    };
  };

    fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Karachi";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ur_PK";
    LC_IDENTIFICATION = "ur_PK";
    LC_MEASUREMENT = "ur_PK";
    LC_MONETARY = "ur_PK";
    LC_NAME = "ur_PK";
    LC_NUMERIC = "ur_PK";
    LC_PAPER = "ur_PK";
    LC_TELEPHONE = "ur_PK";
    LC_TIME = "ur_PK";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
