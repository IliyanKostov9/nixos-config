{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.okular;
in
{
  options.modules.okular = { enable = mkEnableOption "okular"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.okular
    ];
  };

}
