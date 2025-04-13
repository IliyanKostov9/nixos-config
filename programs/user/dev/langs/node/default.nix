{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.langs.node;
in {
  options.modules.dev.langs.node = {enable = mkEnableOption "node";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nodejs_22
    ];
  };
}
