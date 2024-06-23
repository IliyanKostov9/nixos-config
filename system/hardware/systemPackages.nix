{ config, lib, pkgs, ... }:

{
  imports = [
    ../../../programs/system
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable programs
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  # For Android
  programs.gpaste.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

}
