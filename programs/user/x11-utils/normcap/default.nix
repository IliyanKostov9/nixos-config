{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.normcap;
in
{
  options.modules.normcap = { enable = mkEnableOption "normcap"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.normcap
    ];
  };

}
