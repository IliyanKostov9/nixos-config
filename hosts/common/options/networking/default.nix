{lib, ...}: let
  host-name = "baks";
in {
  networking = {
    hostName = host-name;
    # nameservers = ["192.168.88.99"]; # NOTE: Router is handling that now
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
