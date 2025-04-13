{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.linters.yamllint;
in {
  options.modules.dev.linters.yamllint = {enable = mkEnableOption "yamllint";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.yamllint
    ];
  };
}
