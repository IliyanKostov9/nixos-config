{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.monitor;
in
{
  options.modules.monitor = { enable = mkEnableOption "monitor"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      htop
      neofetch
    ];
  };

}

