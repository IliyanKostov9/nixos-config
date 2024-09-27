{ config, ... }:
{
  config.modules = {

    curl.enable = true;
    home-manager.enable = true;
    nix-output-monitor.enable = true;
    wget.enable = true;

    # Deps -> GNU
    gnu.enable = true;
    # Disable default gnome apps
    gnome-disable-default-apps.enable = true;

    # Deps -> Lib
    lib.enable = true;

    # Deps -> Security
    security.enable = true;

    # Deps -> Utils
    file-listing.enable = true;
    fzf.enable = true;
    monitor.enable = true;
    xclip.enable = true;
    zip.enable = true;

    # Desktop control center
    audio.enable = true;
    pcmanfm.enable = true;
    network.enable = true;
    red-light.enable = true;

    # Desktop control center > display-manager
    catppuccin-sddm.enable = true;

    # Editor
    vim.enable = true;

    # SCM
    git.enable = true;
  };
}
