{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.sqlite;
in
{
  options.modules.sqlite = { enable = mkEnableOption "sqlite"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.sqlite
    ];
  };

}

