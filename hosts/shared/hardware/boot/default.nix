{ ... }:
{
  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
    "/boot" =
      {
        device = "/dev/disk/by-label/NIXOS_BOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
  };
}
