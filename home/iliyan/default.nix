{
  lib,
  config,
  pkgs,
  ...
}: let
  env-vars = {
    ZVM_CURSOR_STYLE_ENABLED = "false";
    ZVM_INIT_MODE = "sourcing";
    AUTOPAIR_INIT_INHIBIT = "1";
  };
in {
  imports = [
    # ./options/overlays
    ./options/blueman-applet
    ../../programs/user
  ];

  config.modules = {
    window-manager.sway = {
      enable = true;
      enable-laptop-display = false;
      browser-exec = "chromium --profile-directory=";
      browser-mappings = {
        "m" = "Profile 7"; # Main
        "g" = "Profile 6"; # Music
        "y" = "Profile 2"; # Youtube
        "w" = "Profile 3"; # Work
      };
    };

    preferences.fonts = {
      name = "0xProto";
      size = 17;
    };

    browsers.librewolf = {
      package = null; # NOTE: For firejail
      enable = false;
      profiles = import ./options/librewolf/profiles {inherit pkgs;};
    };

    dev = {
      command-line = {
        bat.enable = true;
        eza.enable = true;
        ggshield.enable = true;
      };
      container.docker.enable = true;
      editor.neovim.enable = true;
      dbms.dbeaver.enable = true;

      emulator = {
        default = "ghostty";
        ghostty.enable = true;
        alacritty = {
          enable = false;
          theme = "kanagawa_dragon";
          scheduled = false;
          start-hour = 7;
          end-hour = 16;
          light-theme = "rose_pine_dawn";
          dark-theme = "kanagawa_dragon";
          light-theme-hex = "#faf4ed";
          dark-theme-hex = "#181616";
        };
        tmux.enable = true;
      };

      git = {
        gh.enable = true;
        git = {
          enable = true;
          userName = "iliyan-kostov";
          userEmail = "iliyan.kostov@email.ikostov.org";
          shouldGPGSign = true;
          gpgKey = "6105AB13B9DCDD1B";
        };
        git-extras.enable = true;
      };

      shell = {
        bash = {
          enable = true;
          inherit env-vars;
        };
        zsh = {
          enable = true;
          inherit env-vars;
        };
      };
    };
    iot.qFlipper.enable = true;

    media = {
      gimp.enable = false;
      obs-studio.enable = true;
    };

    office-suite = {
      syncthing.enable = true;
      drawio.enable = true;
      flameshot.enable = true;
    };

    virtualisation.lazydocker.enable = true;
    vpn.openvpn.enable = true;
  };
}
