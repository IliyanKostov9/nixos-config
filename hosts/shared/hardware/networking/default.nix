{ lib, host_attr, ... }:

{
  networking = {
    hostName = host_attr.host-name;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.k3s =
    {
      enable = lib.mkDefault false; # Disabled because I'm currently not using it atm
      role = "server";
    };
}
