{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./bluetooth
      ./cups
      ./firmware
      ./locale
      ./networking
      ./opengl
      ./pipewire
      ./security
      ./systemd
      ./xserver
    ];
}
