{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.flatpak;
in {
  options.modules.downloader.flatpak = {enable = mkEnableOption "flatpak";};

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
