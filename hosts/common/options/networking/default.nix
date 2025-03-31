{
  lib,
  host_attr,
  ...
}: let
  host-name = "baks";
in {
  networking = {
    # proxy.default = "http://192.168.1.99:3128";
    hostName = host-name;
    # nameservers = [ pi-hole-dns ];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
