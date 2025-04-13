{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.iot.qFlipper;
in {
  options.modules.iot.qFlipper = {enable = mkEnableOption "qFlipper";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.qFlipper
    ];
  };
}
