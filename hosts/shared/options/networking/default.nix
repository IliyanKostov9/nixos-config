{ lib, host_attr, ... }:

{
  networking = {
    hostName = host_attr.host-name;
    # nameservers = [ pi-hole-dns ];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
