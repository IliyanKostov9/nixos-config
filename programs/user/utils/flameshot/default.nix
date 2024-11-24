{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.flameshot;
in
{
  options.modules.utils.flameshot = { enable = mkEnableOption "flameshot"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.flameshot
    ];
  };

}

