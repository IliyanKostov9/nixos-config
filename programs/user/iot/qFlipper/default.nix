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
  # NOTE: To enable it use the following commands:
  # nix-shell -p xhost
  # xhost +SI:localuser:root
  # sudo qFlipper

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qFlipper
    ];
  };
}
