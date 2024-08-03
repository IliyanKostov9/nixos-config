{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./displayManager
      ./nvidia
      ./systemd
      ../../../shared/hardware
    ];
}
