{ ... }:
{
  fileSystems."/mnt/HDD" = {
    device = "/dev/sdb1";
    fsType = "ntfs";
    options = [ "users" "nofail" "rw" ];
  };
}
