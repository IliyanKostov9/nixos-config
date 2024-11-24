{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.password-manager.keepass;
in
{
  options.modules.password-manager.keepass = { enable = mkEnableOption "keepass"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.keepass
    ];
  };

}
