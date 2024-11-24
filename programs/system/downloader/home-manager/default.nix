{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.downloader.home-manager;
in
{
  options.modules.downloader.home-manager = { enable = mkEnableOption "home-manager"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.home-manager
    ];
  };
}
