{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./boot
      ./displayManager
      ./filesystem
      ./nvidia
      ../../../shared/hardware
    ];
}
