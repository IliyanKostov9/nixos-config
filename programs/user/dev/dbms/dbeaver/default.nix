{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.dbms.dbeaver;
in {
  options.modules.dev.dbms.dbeaver = {enable = mkEnableOption "dbeaver";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dbeaver-bin
    ];
  };
}
