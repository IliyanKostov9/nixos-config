{ lib, pkgs, modulesPath, host_attr, ... }:

with host_attr; {

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = boot // {
    kernelPackages = pkgs.linuxPackages_6_11;
    loader = {
      systemd-boot.enable = if builtints.pathExists "/etc/secureboot" then false else true;
      efi.canTouchEfiVariables = true;
    };
  } // (if builtins.pathExists "/etc/secureboot" then {
    # NEEDED: For Garnix
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  } else { });
}
