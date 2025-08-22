{
  lib,
  host_attr,
  config,
  ...
}: let
  host-name = "baks";
in {
  networking = {
    hostName = host-name;
    nameservers = ["192.168.1.99"];
    # nameservers = ["100.100.100.100" "8.8.8.8" "1.1.1.1"];
    # search = ["persian-tortoise.ts.net"];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
