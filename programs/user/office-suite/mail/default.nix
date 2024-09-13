{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.mail;
in
{
  options.modules.mail = { enable = mkEnableOption "mail"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.evolution
    ];
  };

}
