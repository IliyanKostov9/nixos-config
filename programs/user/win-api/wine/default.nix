{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.wine;
in
{
  options.modules.wine = { enable = mkEnableOption "wine"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wineWowPackages.waylandFull
      winetricks
    ];
  };

}
