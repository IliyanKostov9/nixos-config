{ config, lib, pkgs, ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1389313b-f022-47fa-b319-86f679186c5c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E602-D2C4";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
}
