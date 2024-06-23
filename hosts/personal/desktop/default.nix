{ config, lib, pkgs, nixos-hardware, ... }:

{
  # NixOS version
  system.stateVersion = "24.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  imports = with nixos-hardware.nixosModules;
    [
      ../../../hardware/personal/desktop
    ];
}

