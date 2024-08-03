{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./nixpkgs
      ./blueman
      ./env-vars
      ./i3
      ./fonts
      ./openvpn
      ./shell
      ./users
      ./virtualisation
      ./programs
    ];
}
