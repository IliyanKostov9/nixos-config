{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vnc;
in
{
  options.modules.vnc = { enable = mkEnableOption "vnc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.realvnc-vnc-viewer
    ];
  };

}
