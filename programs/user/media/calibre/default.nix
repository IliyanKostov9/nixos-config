{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.calibre;
in
{
  options.modules.calibre = { enable = mkEnableOption "calibre"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.calibre
    ];
  };

}
