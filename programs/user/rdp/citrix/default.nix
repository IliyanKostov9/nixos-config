{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.rdp.citrix;
in
{
  options.modules.rdp.citrix = { enable = mkEnableOption "citrix"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.citrix_workspace
    ];
  };

}
