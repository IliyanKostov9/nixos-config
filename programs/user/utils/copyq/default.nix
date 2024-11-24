{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.copyq;
in
{
  options.modules.utils.copyq = { enable = mkEnableOption "copyq"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.copyq
    ];
  };

}
