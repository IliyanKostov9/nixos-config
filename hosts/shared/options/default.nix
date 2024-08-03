{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./nixpkgs
      ./blueman
      ./env-vars
      ./i3
      ./nerdfonts
      ./openvpn
      ./shell
      ./users
      ./virtualisation
      ./programs
    ];
}
