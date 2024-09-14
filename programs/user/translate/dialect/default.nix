{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dialect;
in
{
  options.modules.dialect = { enable = mkEnableOption "dialect"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dialect
    ];
  };

}
