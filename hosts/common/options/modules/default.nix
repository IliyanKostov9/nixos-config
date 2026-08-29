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
      version = "610.57.04";
      sha256_64bit = "sha256-suk1xmuDuwDAyFe8jg7g/VLekoa0DJzB7sKafOfrEW0=";
      sha256_aarch64 = "sha256-QCefrMBCmpOwuOyXv1k5Gj0iB2CYlPgnG3JToUw/j54=";
      openSha256 = "sha256-rQHOOOY4KL92Ww3KDwh+j4eGU7oNAH8LutZC5wmFnPo=";
      settingsSha256 = "sha256-ZEMo8I8Zc2Tq6RVDNYpAH+f094dUaZiBqO+5f6lIjRI=";
      persistencedSha256 = "sha256-aXmD2VY1RLlgAnlHhOUMWzvMyhI6JTClcFLm4imF/mA=";
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

    utils = {
      files.enable = true;
      fzf.enable = true;
      monitor.enable = true;
      make.enable = true;
    };

    desktop-settings = {
      audio.pipewire.enable = true;
      file-manager.pcmanfm.enable = true;
      network.enable = true;
      display-manager.catppuccin-sddm.enable = true;
    };

    editor.vim.enable = true;
    scm.git.enable = true;
    dev.keyd = {
      enable = true;
      mappings = {
        "rightshift" = "down";
        #"rightcontrol" = "overload(right_control_layer, rightcontrol)";
        "rightcontrol" = "right";
        "rightalt" = "up";
      };
    };
  };
}
