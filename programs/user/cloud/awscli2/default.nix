{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.awscli2;
in
{
  options.modules.awscli2 = { enable = mkEnableOption "awscli2"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.awscli2
    ];
  };

}
