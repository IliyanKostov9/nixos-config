{
  lib,
  host_attr,
  config,
  ...
}: let
  host-name = "baks";
in {
  networking = {
    # proxy.default = "http://192.168.1.12:8080";
    hostName = host-name;
    nameservers = ["100.100.100.100" "8.8.8.8" "1.1.1.1"];
    search = ["persian-tortoise.ts.net"];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
