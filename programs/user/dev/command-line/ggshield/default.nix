{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.ggshield;
in
{
  options.modules.ggshield = { enable = mkEnableOption "ggshield"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.ggshield
    ];
  };

}
