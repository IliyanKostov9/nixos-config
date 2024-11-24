{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.gpick;
in
{
  options.modules.utils.gpick = { enable = mkEnableOption "gpick"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gpick
    ];
  };

}

