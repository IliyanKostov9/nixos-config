{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.media.gobs-studio;
in
{
  options.modules.media.gobs-studio = { enable = mkEnableOption "obs-studio"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.obs-studio
    ];
  };

}
