{ lib, host_attr, ... }:

{
  networking = {
    hostName = host_attr.host-name;
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall = {
      allowedTCPPorts = [
        6443
        22
        # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
        # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
      ];
      allowedUDPPorts = [
        8472
      ];
    };
  };

  services.k3s =
    {
      enable = false; # Disabled because I'm currently not using it atm
      role = "server";
      extraFlags = toString [
        # "--kubelet-arg=v=4" # Optionally add additional args to k3s
      ];
    };
}
