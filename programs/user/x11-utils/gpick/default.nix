{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gpick;
in
{
  options.modules.gpick = { enable = mkEnableOption "gpick"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gpick
    ];
  };

}

