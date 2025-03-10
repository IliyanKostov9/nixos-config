{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.dbms.sqlite;
in {
  options.modules.dev.dbms.sqlite = {enable = mkEnableOption "sqlite";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sqlite
    ];
  };
}
