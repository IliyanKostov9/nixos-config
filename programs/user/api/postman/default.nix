{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.api.postman;
in {
  options.modules.api.postman = {enable = mkEnableOption "postman";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.postman
    ];
  };
}
