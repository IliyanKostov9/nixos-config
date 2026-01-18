_: {
  config.modules = {
    hardware.power-saver.enable = false;
    options.locale = {
      timeZone = "Europe/Paris";
      defaultLocale = "en_US.UTF-8";
    };

    window-manager.sway.enable = true;
    vpn.tailscale.enable = true;

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
      files = true;
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
