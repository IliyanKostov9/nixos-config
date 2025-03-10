{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.normcap;
in {
  options.modules.utils.normcap = {enable = mkEnableOption "normcap";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.normcap
    ];
  };
}
