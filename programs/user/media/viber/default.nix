{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.media.gviber;
in
{
  options.modules.media.gviber = { enable = mkEnableOption "viber"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs_unstable;[
      viber
    ];
  };

}
