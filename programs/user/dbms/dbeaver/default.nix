{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dbeaver;
in
{
  options.modules.dbeaver = { enable = mkEnableOption "dbeaver"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.dbeaver-bin
    ];
  };

}
