{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./blueman
      ./env-vars
      ./i3
      ./nerdfonts
      ./openvpn
      ./nixpkgs
      ./shell
      ./users
      ./virtualisation
      ./programs
    ];
}
