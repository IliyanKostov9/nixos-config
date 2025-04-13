{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vpn.cisco-anyconnect;
in {
  options.modules.vpn.cisco-anyconnect = {enable = mkEnableOption "cisco-anyconnect";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.openconnect
    ];
  };
}
