{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.qFlipper;
in
{
  options.modules.qFlipper = { enable = mkEnableOption "qFlipper"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.qFlipper
    ];
  };

}
