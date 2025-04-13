{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.nix.nix-output-monitor;
in {
  options.modules.downloader.nix.nix-output-monitor = {enable = mkEnableOption "nix-output-monitor";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nix-output-monitor
    ];
  };
}
