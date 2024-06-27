{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./bluetooth
      ./cups
      ./firmware
      ./networking
      ./opengl
      ./pipewire
      ./security
      ./systemd
      ./xserver
    ];
}
