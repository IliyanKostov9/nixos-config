_: {
  config.modules = {
    hardware = {
      boot.kernel = "7_1";
      power-saver.enable = false;
      firmware.disableTouchpad = true;
      keyboard.console = "dvorak";
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
        enableSync = true;
        enableOffload = false;
      };
    };

    options.locale = {
      timeZone = "Europe/Sofia";
      defaultLocale = "en_US.UTF-8";
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
