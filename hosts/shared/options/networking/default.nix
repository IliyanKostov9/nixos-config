{ lib, host_attr, ... }:

{
  networking = {
    hostName = host_attr.host-name;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
