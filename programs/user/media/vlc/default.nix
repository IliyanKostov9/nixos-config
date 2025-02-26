{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.media.vlc;
in
{
  options.modules.media.vlc = { enable = mkEnableOption "vlc"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vlc
    ];
  };
}
