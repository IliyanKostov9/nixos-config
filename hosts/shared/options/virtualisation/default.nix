{ config, lib, pkgs, ... }:
{
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
