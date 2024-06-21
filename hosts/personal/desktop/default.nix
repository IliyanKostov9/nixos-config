{ config, lib, pkgs, nur, nixos-hardware, ... }:

let

in
{
  imports = with nixos-hardware.nixosModules;
    [
      ../../../hardware/personal/desktop
    ];
}

