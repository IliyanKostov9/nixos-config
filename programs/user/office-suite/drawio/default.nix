{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.drawio;
in {
  options.modules.office-suite.drawio = {enable = mkEnableOption "drawio";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.drawio
      pkgs.gpick
    ];
  };
}
