{ lib, pkgs, modulesPath, host_attr, ... }:

with host_attr; {

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = boot // {
    kernelPackages = pkgs.linuxPackages_6_11;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      # DISABLED: Required by lanzaboote secure boot
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
  };
}
