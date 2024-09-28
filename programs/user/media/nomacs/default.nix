{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nomacs;
in
{
  options.modules.nomacs = { enable = mkEnableOption "nomacs"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nomacs
    ];
  };

}
