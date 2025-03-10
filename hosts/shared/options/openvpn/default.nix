{
  config,
  lib,
  ...
}: let
  inherit (config.sops) secrets;
  ovpn-path = "/var/lib/openvpn/personalVPN.ovpn";
  is-ovpn-present =
    if builtins.pathExists ovpn-path
    then true
    else false;
in {
  services.openvpn.servers = {
    personalVPN = {
      config = "config ${ovpn-path}";
      authUserPass = lib.mkIf (!lib.trivial.inPureEvalMode) {
        username = builtins.readFile secrets.ovpn_username.path;
        password = builtins.readFile secrets.ovpn_password.path;
      };
      updateResolvConf = false; # NOTE set to false for pi-hole DNS use
      autoStart = is-ovpn-present;
    };
  };
}
