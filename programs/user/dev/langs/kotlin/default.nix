{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.langs.kotlin;
in {
  options.modules.dev.langs.kotlin = {enable = mkEnableOption "kotlin";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.kotlin
    ];
  };
}
