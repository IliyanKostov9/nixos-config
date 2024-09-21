{ pkgs, pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.awscli2;
in
{
  options.modules.awscli2 = { enable = mkEnableOption "awscli2"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.awscli2
      pkgs.aws-sam-cli
    ];
  };

}
