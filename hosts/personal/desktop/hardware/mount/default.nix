_: {
  fileSystems."/mnt/HDD" = {
    device = "/dev/disk/by-label/NIXOS_HDD";
    fsType = "ntfs";
    options = [ "users" "nofail" "rw" ];
  };
}
