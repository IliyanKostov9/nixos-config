{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.git.git-extras;
in {
  options.modules.dev.git.git-extras = {enable = mkEnableOption "git-extras";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.git-extras
    ];
  };
}
