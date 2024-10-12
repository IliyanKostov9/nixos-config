{ lib, pkgs, modulesPath, host_attr, ... }:

with host_attr;
let
  is-secure-boot-enabled = builtins.pathExists "/etc/secureboot";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = boot // {
    kernelPackages = pkgs.linuxPackages_6_11;
    loader = {
      # Note: is-secure-boot-enabled value is reverted, since system boot expects to be true when secure boot is disabled and vice versa
      systemd-boot.enable = !is-secure-boot-enabled;
      efi.canTouchEfiVariables = true;
    };
  } // (if is-secure-boot-enabled then {
    # NEEDED: For Garnix
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  } else { });
}
