{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.red-light;
in
{
  options.modules.red-light = { enable = mkEnableOption "red-light"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ redshift ];
  };

}

