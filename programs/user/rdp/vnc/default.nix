{ pkgs-unstable, lib, config, ... }:
with lib;
let cfg = config.modules.rdp.vnc;
in
{
  options.modules.rdp.vnc = { enable = mkEnableOption "vnc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs-unstable.realvnc-vnc-viewer
    ];
  };

}
