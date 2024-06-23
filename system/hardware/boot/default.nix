{ config, lib, pkgs, modulesPath, nur, nixos-hardware, ... }:

{
  imports = [

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices =
    [{ device = "/dev/disk/by-uuid/85b811ca-f0aa-452e-a679-549dcf80e1ba"; }];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-401c9fe6-6316-449a-8a50-2e46ac3a5401".device = "/dev/disk/by-uuid/401c9fe6-6316-449a-8a50-2e46ac3a5401";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."luks-2d79801c-f1b7-4300-b4db-b9eff4b0f110".device = "/dev/disk/by-uuid/2d79801c-f1b7-4300-b4db-b9eff4b0f110";

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_6_9;
}
