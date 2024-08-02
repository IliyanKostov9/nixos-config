{ config, lib, pkgs, ... }:
{

  # NixOS version
  system.stateVersion = lib.mkDefault "24.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = lib.mkDefault true;
    allowBroken = lib.mkDefault true;
  };
}
