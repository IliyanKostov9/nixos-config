{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cisco-anyconnect;
in
{
  options.modules.cisco-anyconnect = { enable = mkEnableOption "cisco-anyconnect"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.openconnect
    ];
  };

}
