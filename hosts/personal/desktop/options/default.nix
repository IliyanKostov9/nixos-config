{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./android
      ./blueman
      ./env-vars
      ./firefox
      ./gpaste
      ./i3
      ./neovim
      ./nerdfonts
      ./openvpn
      ./users
      ./virtualisation
    ];
}
