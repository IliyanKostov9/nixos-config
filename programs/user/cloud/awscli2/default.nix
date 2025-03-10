{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.cloud.awscli2;
in {
  options.modules.cloud.awscli2 = {enable = mkEnableOption "awscli2";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs-unstable.awscli2
      pkgs.aws-sam-cli
    ];
  };
}
