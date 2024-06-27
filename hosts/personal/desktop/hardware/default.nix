{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./boot
      ./displayManager
      ./filesystem
      ./nvidia
      ./systemd
      ../../../shared/hardware
    ];
}
