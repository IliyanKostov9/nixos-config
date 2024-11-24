{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.media.gimp;
in
{
  options.modules.media.ggimp = { enable = mkEnableOption "gimp"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gimp
    ];
  };

}
