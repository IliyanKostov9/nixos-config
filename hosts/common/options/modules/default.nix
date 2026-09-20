_: {
  config.modules = {
    hardware = {
      boot.kernel = "7_2";
      power-saver.enable = true;
      firmware.disableTouchpad = true;
      keyboard = {
        console = "dvorak";
        # NOTE: Props to: https://github.com/ivangeorgiew for providing the missing Dvorak for bg
        extraLayouts.bgd = {
          description = "Bulgarian Dvorak";
          languages = ["bul"];
          symbolsFile = ../../options/xkb/dvorak/bgd;
        };
      };
    };

    nvidia = {
      openSource = true;
      channel = "";
      version = "615.71.09";
      sha256_64bit = "sha256-zc7tIrvrYSSNGm3qvCWWZz46ZQFpjucayNL9wo87cP4=";
      sha256_aarch64 = "sha256-IbekQhE7cFfmnPZaLY9NDYcF7CoNZ+2Qb7sRd4EOgWM=";
      openSha256 = "sha256-3gByMYIwFzRaLdDG+roCEOuKRRJDrljG9AlLnRZTirM=";
      settingsSha256 = "sha256-LK1LU8mDkM/XVRKPBtuOZh9nIP/lGFLAJnmasEX8jhg=";
      persistencedSha256 = "sha256-qPRb+3d88+2RcpUkoBTbjIaImnQ+jX+/6p1vXcJ5geE=";
      prime = {
        enableSync = false;
        enableOffload = true;
      };
    };

    options = {
      garbage-collect = {
        enable = true;
        schedule = "weekly";
      };
      locale = {
        timeZone = "Europe/Sofia";
        defaultLocale = "fr_FR.UTF-8";
      };
      networking.nameservers = [];
    };

    window-manager.sway.enable = true;
    vpn = {
      tailscale.enable = true;
      openvpn = {
        enable = true;
        autoStart = true;
      };
    };

    downloader = {
      curl.enable = true;
      home-manager.enable = true;
      wget.enable = true;
      nix.nix-output-monitor.enable = true;
    };

    lib.nix-ld.enable = true;
    gnome-disable-apps.enable = true;

    security = {
      cryptography.enable = true;
      firejail.enable = true;
      login.enable = true;
    };

    files.enable = true;
    monitor.enable = true;

    desktop-settings = {
      audio.pipewire.enable = true;
      file-manager.pcmanfm.enable = true;
      network.enable = true;
      display-manager.catppuccin-sddm.enable = true;
    };

    scm.git.enable = true;
    office-suite.enable = true;

    dev = {
      editor.vim.enable = true;
      make.enable = true;
      keyd = {
        enable = true;
        mappings = {
          "rightshift" = "down";
          #"rightcontrol" = "overload(right_control_layer, rightcontrol)";
          "rightcontrol" = "right";
          "rightalt" = "up";
        };
      };
    };
  };
}
