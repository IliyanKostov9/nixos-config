{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.openvpn3;
in
{
  options.modules.openvpn3 = { enable = mkEnableOption "openvpn3"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.openvpn3
    ];
  };

}
