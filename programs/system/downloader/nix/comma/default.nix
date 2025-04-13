{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.downloader.nix.comma;
in {
  options.modules.downloader.nix.comma = {enable = mkEnableOption "comma";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.comma
    ];
  };
}
