_: {
  config.modules = {

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
      dir-content-ls.enable = true;
      fzf.enable = true;
      monitor.enable = true;
      xclip.enable = true;
      make.enable = true;
    };

    desktop-settings = {
      audio.enable = true;
      file-manager.pcmanfm.enable = true;
      network.enable = true;
      display-manager.catppuccin-sddm.enable = true;
    };

    editor.vim.enable = true;
    scm.git.enable = true;
    dev.keyd =
      {
        enable = true;
        mappings = {
          # "f1" = "left";
          # "f2" = "down";
          # "f3" = "up";
          # "f4" = "right";
          # "left" = "f1";
          # "down" = "f2";
          # "up" = "f3";
          # "right" = "f4";
          "rightshift" = "backspace";
          "rightcontrol" = "right";
        };
      };
  };
}
