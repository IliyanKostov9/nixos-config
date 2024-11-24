{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.media.viber;
in
{
  options.modules.media.viber = { enable = mkEnableOption "viber"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs_unstable;[
      viber
    ];
  };

}
