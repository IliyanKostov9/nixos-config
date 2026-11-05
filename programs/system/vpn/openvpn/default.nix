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
    system.preSwitchChecks.ovpnFile = lib.mkIf cfg.autoStart ''
      if [ ! -f ${ovpn-path} ]; then
        echo "Autostart is enabled, but OVPN file ${ovpn-path} is missing!" >&2
        exit 1
      fi
    '';

    services.openvpn.servers = {
      personalVPN = {
        config = ''
          config ${ovpn-path}
          auth-user-pass ${config.sops.templates."ovpn-auth".path}
        '';
        updateResolvConf = false; # NOTE: set to false for pi-hole DNS use
        autoStart = cfg.autoStart;
      };
    };
  };
}
