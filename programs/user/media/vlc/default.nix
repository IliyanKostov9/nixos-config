{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.media.gvlc;
in
{
  options.modules.media.gvlc = { enable = mkEnableOption "vlc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vlc
    ];
  };

}
