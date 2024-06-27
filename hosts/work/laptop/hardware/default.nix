{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./bluetooth
      ./boot
      ./cups
      ./displayManager
      ./filesystem
      ./firmware
      ./networking
       ./nvidia
       ./opengl
      ./pipewire
      ./security
      ./systemd
      ./xserver
    ];
}
