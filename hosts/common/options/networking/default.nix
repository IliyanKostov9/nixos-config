{
  lib,
  host_attr,
  ...
}: let
  host-name = "baks";
in {
  networking = {
    # proxy.default = "http://192.168.1.12:8080";
    hostName = host-name;
    # nameservers = ["192.168.1.99"];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
  # 192.168.1.1
  # 255.255.255.0
  # 192.168.1.10
  # 192.168.1.150
}
