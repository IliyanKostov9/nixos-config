{ config, lib, pkgs, ... }:

{
  networking.hostName = "baks";
  networking.networkmanager.enable = true;
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;
  # Decrease time spent making connections
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings = {
  #     IPv6 = {
  #       Enabled = true;
  #     };
  #     Settings = {
  #       AutoConnect = true;
  #     };
  #   };
  # };
  networking.firewall.allowedTCPPorts = [
    6443
    22
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    8472
  ];
  services.k3s.enable = false; # Disabled because I'm currently not using it atm
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];
}
