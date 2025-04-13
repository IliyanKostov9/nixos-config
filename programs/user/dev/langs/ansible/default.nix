{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.langs.ansible;
in {
  options.modules.dev.langs.ansible = {enable = mkEnableOption "ansible";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ansible
    ];
  };
}
