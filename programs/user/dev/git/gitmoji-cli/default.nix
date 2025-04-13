{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.git.gitmoji-cli;
in {
  options.modules.dev.git.gitmoji-cli = {enable = mkEnableOption "gitmoji-cli";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gitmoji-cli
    ];
  };
}
