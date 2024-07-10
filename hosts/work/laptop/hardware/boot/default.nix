{ config, lib, pkgs, modulesPath, nur, nixos-hardware, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices =
    [{ device = "/dev/disk/by-uuid/2ae616fa-be73-4075-be15-72f4fb245205"; }];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-98c6023d-534b-436b-b8c6-151500769ae9".device = "/dev/disk/by-uuid/98c6023d-534b-436b-b8c6-151500769ae9";
  boot.initrd.luks.devices."luks-af43f1f4-e396-4104-af8d-ab8ee1721612".device = "/dev/disk/by-uuid/af43f1f4-e396-4104-af8d-ab8ee1721612";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Intel Graphics
  boot.kernelParams = [ "i915.force_probe=3e9b" ];

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_6_9;
}
