{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.viber;
in
{
  options.modules.viber = { enable = mkEnableOption "viber"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs_unstable;[
      viber
    ];
  };

}
