{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./android
      ./blueman
      ./env-vars
      ./firefox
      ./gnupg
      ./gpaste
      ./i3
      ./lib
      ./neovim
      ./nerdfonts
      ./openvpn
      ./users
      ./virtualisation
    ];
}
