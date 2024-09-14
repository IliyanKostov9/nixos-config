{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.network;
in
{
  options.modules.network = { enable = mkEnableOption "network"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ networkmanagerapplet ];
  };

}

