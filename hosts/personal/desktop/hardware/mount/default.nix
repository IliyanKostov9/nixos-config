{ ... }:
{
  fileSystems."/mnt/external_hd" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [ "users" "nofail" "rw" ];
  };
}
