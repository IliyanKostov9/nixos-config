{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.app-search;
in
{
  options.modules.app-search = { enable = mkEnableOption "app-search"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xfce.xfce4-appfinder
    ];
  };

}

