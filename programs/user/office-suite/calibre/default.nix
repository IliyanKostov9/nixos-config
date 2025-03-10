{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.calibre;
in {
  options.modules.office-suite.calibre = {enable = mkEnableOption "calibre";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.calibre
    ];
  };
}
