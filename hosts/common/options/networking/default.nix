{
  lib,
  host_attr,
  config,
  ...
}: let
  host-name = "baks";
  inherit (config.sops) secrets;
in {
  networking = {
    # proxy.default = "http://192.168.1.12:8080";
    hostName = host-name;
    nameservers = ["100.100.100.100" "8.8.8.8" "1.1.1.1"];
    search = [builtins.readFile secrets.networking_search.path];
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
