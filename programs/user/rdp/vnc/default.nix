{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.vnc;
in
{
  options.modules.vnc = { enable = mkEnableOption "vnc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs_unstable.realvnc-vnc-viewer
    ];
  };

}
