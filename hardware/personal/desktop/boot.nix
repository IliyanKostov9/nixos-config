{ config, lib, pkgs, modulesPath, nur, nixos-hardware, ... }:

{

  imports = [

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."luks-2d79801c-f1b7-4300-b4db-b9eff4b0f110".device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";

  boot.loader.grub.device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_6_9;
}
