{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.virtualisation.aws-workspaces;
in
{
  options.modules.virtualisation.aws-workspaces = { enable = mkEnableOption "aws-workspaces"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.aws-workspaces
    ];
  };

}
