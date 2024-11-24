{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.rdp.vnc;
in
{
  options.modules.rdp.vnc = { enable = mkEnableOption "vnc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.realvnc-vnc-viewer
    ];
  };

}
