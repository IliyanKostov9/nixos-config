{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.browsers.microsoft-edge;
in {
  options.modules.browsers.microsoft-edge = {enable = mkEnableOption "microsoft-edge";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.microsoft-edge
    ];
  };
}
