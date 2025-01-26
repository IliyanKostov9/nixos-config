{ lib, host_attr, ... }:

let pi-hole-dns = "192.168.1.99";
in
{
  networking = {
    hostName = host_attr.host-name;
    # nameservers = [ pi-hole-dns ];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
