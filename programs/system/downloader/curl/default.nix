{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.curl;
in {
  options.modules.downloader.curl = {enable = mkEnableOption "curl";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.curl
    ];
  };
}
