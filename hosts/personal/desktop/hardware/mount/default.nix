{ ... }:
{
  fileSystems."/mnt/external_hd" = {
    device = "/dev/sdb1";
    fsType = "ntfs";
    options = [ "users" "nofail" "rw" ];
  };
}
