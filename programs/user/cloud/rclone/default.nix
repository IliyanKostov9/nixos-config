{pkgs,  lib, config, ... }:
with lib;
let cfg = config.modules.rclone;
in
{
  options.modules.rclone = { enable = mkEnableOption "rclone"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.rclone
      pkgs.rclone-browser
    ];
  };

}
