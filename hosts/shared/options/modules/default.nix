{ config, ... }:
{
  config.modules = {

    downloader = {
      curl.enable = true;
      home-manager.enable = true;
      wget.enable = true;

      nix = {
        nix-output-monitor.enable = true;
      };
    };

    lib = {
      gnu.enable = true;
      media.enable = true;
      utils.enable = true;
      nix-ld.enable = true;
    };

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
      zip.enable = true;
    };

    desktop-settings = {
      audio.enable = true;
      file-manager.pcmanfm.enable = true;
      network.enable = true;
      display-manager.catppuccin-sddm.enable = true;
    };


    editor = {
      vim.enable = true;
    };

    scm = {
      git.enable = true;
    };
  };
}
