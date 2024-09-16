{ pkgs, config, ... }:
{

  config.modules = {

    # Build tools
    maven.enable = true;
    gradle.enable = true;

    # Container
    docker.enable = true;
    k8s.enable = true;

    # Deps -> Downloader
    curl.enable = true;
    home-manager.enable = true;
    nix-output-monitor.enable = true;
    wget.enable = true;

    # Deps -> GNU
    gnu.enable = true;

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

    # Editor
    vim.enable = true;

    # SCM
    git.enable = true;
  };
}
