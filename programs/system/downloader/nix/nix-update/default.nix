{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.nix.nix-update;
in {
  options.modules.downloader.nix.nix-update = {enable = mkEnableOption "nix-update";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nix-update
    ];
  };
}
