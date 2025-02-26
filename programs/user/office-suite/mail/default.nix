{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.office-suite.mail;
in
{
  options.modules.office-suite.mail = { enable = mkEnableOption "mail"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.evolution
    ];
  };
}
