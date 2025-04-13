{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.langs.go;
in {
  options.modules.dev.langs.go = {enable = mkEnableOption "go";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go
      delve
    ];
  };
}
