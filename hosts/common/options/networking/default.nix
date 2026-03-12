{lib, ...}: let
  host-name = "baks";
in {
  networking = {
    hostName = host-name;
    nameservers = ["192.168.1.99"];
    firewall = {
      enable = true;
      allowedTCPPorts = [3003];
      allowedUDPPortRanges = [
        {
          from = 3000;
          to = 4000;
        }
      ];
    };
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
