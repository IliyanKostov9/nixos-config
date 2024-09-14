{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.keepass;
in
{
  options.modules.keepass = { enable = mkEnableOption "keepass"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.keepass
    ];
  };

}
