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
      ./neovim
      ./nerdfonts
      ./network
      ./openvpn
      ./users
      ./virtualisation
    ];
}
