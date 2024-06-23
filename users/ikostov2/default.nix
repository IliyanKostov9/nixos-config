{ config, pkgs, ... }:
let
  username = "ikostov2";
in
{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../../pkgs
    ../../dotfiles
  ];
  home = {
    homeDirectory = "/home/${username}";
    inherit username;
  };
  home.stateVersion = "24.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

