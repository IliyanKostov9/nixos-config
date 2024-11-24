{ config, ... }:
let
  inherit (config.sops) secrets;

  ovpn-path = "/var/lib/openvpn/personalVPN.ovpn";
  is-ovpn-present = if builtins.pathExists ovpn-path then true else false;
in
{
  services.openvpn.servers = {
    personalVPN = {
      config = "config ${ovpn-path}";
      # authUserPass = {
      #   username = secrets.tf_org;
      # };
      updateResolvConf = true;
      autoStart = is-ovpn-present;
    };
  };
}
