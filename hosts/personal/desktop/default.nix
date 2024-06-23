{ config, lib, pkgs, nixos-hardware, ... }:

let

in
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  imports = with nixos-hardware.nixosModules;
    [
      ../../../hardware/personal/desktop
    ];
}

