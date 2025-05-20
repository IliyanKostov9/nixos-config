{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite.okular;
in {
  options.modules.office-suite.okular = {enable = mkEnableOption "okular";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.okular
    ];
  };
}
