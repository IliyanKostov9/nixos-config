{ config, lib, pkgs, ... }:

{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/71627bb4-1f3d-4b0c-9b74-aef3944e9eae";
      fsType = "ext4";
    };
  # Mount the hard disk
  fileSystems."/mnt/external_hd" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [ "users" "nofail" "rw" ];
  };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/BB8A-DF92";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}
