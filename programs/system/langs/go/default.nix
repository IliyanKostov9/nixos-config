{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.go;
in
{
  options.modules.go = { enable = mkEnableOption "go"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      go
      delve
    ];
  };

}

