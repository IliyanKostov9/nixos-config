{ pkgs, modulesPath, host_attr, ... }:

with host_attr; {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  inherit swapDevices fileSystems;
  boot = boot // {
    # # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_6_9;
  };
}
