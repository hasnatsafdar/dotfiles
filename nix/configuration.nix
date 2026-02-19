{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  services = {
  picom.enable = true;
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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  users.users.hxt = {
    isNormalUser = true;
    description = "Hasnat Safdar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kanata
      oh-my-posh
      nitch
      fastfetch
      btop
      xwallpaper
      xmobar
      haskell-language-server
      dmenu
      polybar
      rofi
      alacritty
      picom
      yazi
      lf
      stow
      aria2
      cava
      dunst
      tmux
      fzf
      lazygit
      eza
      zoxide
      nitrogen
      hugo
      buku
    ];
  };

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

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    pulseaudio
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
