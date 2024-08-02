{ config, pkgs, stateVersion, ... }:
let
  username = "ikostov2";
in
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../../programs/user/ikostov2.nix
    ./dotfiles
    ./themes
    ./options
  ];
  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
  };

  # Disable annoying home news
  news.display = "silent";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

