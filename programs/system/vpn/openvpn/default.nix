{
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  inherit (config.sops) secrets;
  cfg = config.modules.vpn.openvpn;
  ovpn-path = "/var/lib/openvpn/personalVPN.ovpn";
in {
  options.modules.vpn.openvpn = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable OpenVPN
      '';
    };
    autoStart = mkOption {
      type = bool;
      default = true;
      description = mkDoc ''
        Auto start the OpenVPN service
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = !cfg.autoStart || builtins.pathExists ovpn-path;
        message = "Autostart is enabled, but OVPN file ${ovpn-path} seems to be missing!";
      }
    ];

    services.openvpn.servers = {
      personalVPN = {
        config = "config ${ovpn-path}";
        authUserPass = lib.mkIf (!lib.trivial.inPureEvalMode) {
          username = builtins.readFile secrets.ovpn_username.path;
          password = builtins.readFile secrets.ovpn_password.path;
        };
        updateResolvConf = false; # NOTE: set to false for pi-hole DNS use
        autoStart = cfg.autoStart;
      };
    };
  };
}
