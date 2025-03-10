{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.win-api.wine;
in {
  options.modules.win-api.wine = {enable = mkEnableOption "wine";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wineWowPackages.waylandFull
      winetricks
    ];
  };
}
