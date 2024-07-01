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
}
