{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.office-suite.nomacs;
in
{
  options.modules.office-suite.nomacs = { enable = mkEnableOption "nomacs"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nomacs
    ];
  };

}
