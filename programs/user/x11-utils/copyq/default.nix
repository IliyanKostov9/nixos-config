{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.copyq;
in
{
  options.modules.copyq = { enable = mkEnableOption "copyq"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.copyq
    ];
  };

}
