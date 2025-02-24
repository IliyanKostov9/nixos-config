{ pkgs-unstable, lib, config, ... }:
with lib;
let cfg = config.modules.office-suite.syncthing;
in
{
  options.modules.office-suite.syncthing = { enable = mkEnableOption "syncthing"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs-unstable.syncthing
    ];
  };

}
