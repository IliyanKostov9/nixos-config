{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.i3wm;
in
{
  options.modules.i3wm = { enable = mkEnableOption "i3wm"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3
      picom
      # TODO: Move it to themes module
      rose-pine-icon-theme
    ];
  };

}
