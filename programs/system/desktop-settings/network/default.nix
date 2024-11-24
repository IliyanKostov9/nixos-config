{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop-settings.network;
in
{
  options.modules.desktop-settings.network = { enable = mkEnableOption "network"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ networkmanagerapplet ];
  };
}

