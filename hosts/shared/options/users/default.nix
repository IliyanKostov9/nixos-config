{ config, lib, pkgs, ... }:

{
  users.users.ikostov2 = {
    isNormalUser = true;
    description = "ikostov2";
    extraGroups = [ "libvirtd" "adbusers" "kvm" "docker" "users" "networkmanager" "wheel" ];
    defaultUserShell = pkgs.zsh;
  };
}
