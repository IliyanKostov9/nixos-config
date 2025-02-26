{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vpn.openvpn;
in
{
  options.modules.vpn.openvpn = { enable = mkEnableOption "openvpn"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.openvpn3
    ];
  };

}
