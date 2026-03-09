{ config, pkgs, ... }:

{
  # =========================================================================
  # TRANSMISSION
  # =========================================================================

  services.transmission = {
    enable  = true;
    package = pkgs.transmission_4;
    settings = {
      download-dir = "${config.services.transmission.home}/Downloads";
    };
  };

  # =========================================================================
  # MPD (Music Player Daemon)
  # =========================================================================

  services.mpd = {
    enable = true;
    settings = {
      music_directory  = "/home/hxt/Music";
      bind_to_address  = "127.0.0.1";
    };
  };

  # =========================================================================
  # KANATA (keyboard remapping)
  # =========================================================================

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices        = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        extraDefCfg    = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps a s d f j k l ; lalt ralt
          )

          (defvar
            tap-time  150
            hold-time 200
          )

          (defalias
            a    (multi f24 (tap-hold $tap-time $hold-time a    lmet))
            s    (multi f24 (tap-hold $tap-time $hold-time s    lalt))
            d    (multi f24 (tap-hold $tap-time $hold-time d    lsft))
            f    (multi f24 (tap-hold $tap-time $hold-time f    lctl))
            j    (multi f24 (tap-hold $tap-time $hold-time j    rctl))
            k    (multi f24 (tap-hold $tap-time $hold-time k    rsft))
            l    (multi f24 (tap-hold $tap-time $hold-time l    ralt))
            ;    (multi f24 (tap-hold $tap-time $hold-time ;    rmet))
            lalt (tap-hold $tap-time $hold-time bspc lalt)
            ralt (tap-hold $tap-time $hold-time ret  ralt)
          )

          (deflayer base
            esc @a @s @d @f @j @k @l @; @lalt @ralt
          )
        '';
      };
    };
  };

  # =========================================================================
  # FLATPAK
  # =========================================================================

  services.flatpak.enable = true;
}
