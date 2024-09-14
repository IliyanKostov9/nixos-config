{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnome-software;
in
{
  options.modules.gnome-software = { enable = mkEnableOption "gnome-software"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.gpaste
      indicator-application-gtk3
      gnome.gnome-software
      gnomeExtensions.dock-from-dash
      gnomeExtensions.zen
      gnomeExtensions.search-light
      gnomeExtensions.window-title-is-back
      gnomeExtensions.user-themes
    ];
  };

}
