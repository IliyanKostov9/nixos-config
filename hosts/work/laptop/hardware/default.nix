{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./displayManager
      ./nvidia
      ../../../shared/hardware
    ];
}
