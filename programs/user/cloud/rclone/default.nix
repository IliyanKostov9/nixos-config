{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.cloud.rclone;
in
{
  options.modules.cloud.rclone = { enable = mkEnableOption "rclone"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.rclone
      pkgs.rclone-browser
    ];
  };

}
