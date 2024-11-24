{ config, ... }:
{
  config.modules = {

    downloader = {
      curl.enable = true;
      home-manager.enable = true;
      nix-output-monitor.enable = true;
      wget.enable = true;
    };

    lib = {
      gnu.enable = true;
      nix-ld.enable = true;
    };

    gnome-disable-apps.enable = true;
    security.enable = true;

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
