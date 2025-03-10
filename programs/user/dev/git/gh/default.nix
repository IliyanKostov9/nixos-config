{
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.git.gh;
in {
  options.modules.dev.git.gh = {enable = mkEnableOption "gh";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs-unstable.gh
    ];
  };
}
