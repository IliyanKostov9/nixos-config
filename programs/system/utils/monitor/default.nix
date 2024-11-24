{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.monitor;
in
{
  options.modules.utils.monitor = { enable = mkEnableOption "monitor"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      htop
      neofetch
    ];
  };
}
