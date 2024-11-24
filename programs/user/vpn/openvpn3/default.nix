{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vpn.openvpn3;
in
{
  options.modules.vpn.openvpn3 = { enable = mkEnableOption "openvpn3"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.openvpn3
    ];
  };

}
