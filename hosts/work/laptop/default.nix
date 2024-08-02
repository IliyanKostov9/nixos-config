{ config, lib, pkgs, ... }:

{
  imports = with nixos-hardware.nixosModules;
    [
      ./hardware
      ../../shared/options
      ../../../programs/system
    ];
}

