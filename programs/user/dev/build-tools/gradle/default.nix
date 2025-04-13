{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.build-tools.gradle;
in {
  options.modules.dev.build-tools.gradle = {enable = mkEnableOption "gradle";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gradle
    ];
  };
}
