{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.media.obs-studio;
in
{
  options.modules.media.obs-studio = { enable = mkEnableOption "obs-studio"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.obs-studio
    ];
  };

}
