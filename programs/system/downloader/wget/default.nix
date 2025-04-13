{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.wget;
in {
  options.modules.downloader.wget = {enable = mkEnableOption "wget";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.wget
    ];
  };
}
