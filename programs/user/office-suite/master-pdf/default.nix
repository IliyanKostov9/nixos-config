{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.master-pdf;
in {
  options.modules.office-suite.master-pdf = {enable = mkEnableOption "master-pdf";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.masterpdfeditor4
    ];
  };
}
