{ pkgs, modulesPath, host_attr, ... }:

with host_attr; {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = boot // {
    kernelPackages = pkgs.linuxPackages_6_10;
  };
}
