{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.translate.dialect;
in {
  options.modules.translate.dialect = {enable = mkEnableOption "dialect";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dialect
    ];
  };
}
