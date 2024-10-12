{ lib, pkgs, modulesPath, host_attr, ... }:

with host_attr; {

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = boot // {
    kernelPackages = pkgs.linuxPackages_6_11;
    loader = {
      # DISABLED: Required by lanzaboote secure boot
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
  } // (if builtins.pathExists "/etc/secureboot" then {
    # NEEDED: For Garnix
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  } else builtins.trace "WARN: Secure boot is not enabled. Please enable Secure boot by running 'make setup'");
}
