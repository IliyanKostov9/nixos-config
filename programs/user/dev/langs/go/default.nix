{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.go;
in
{
  options.modules.go = { enable = mkEnableOption "go"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go
      delve
    ];
  };

}

