{ config, lib, pkgs, nixos-hardware, ... }:

{
  # NixOS version
  system.stateVersion = "24.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  imports = with nixos-hardware.nixosModules;
    [
      ./hardware
      ../../shared/options
      ../../../programs/system
    ];
}

