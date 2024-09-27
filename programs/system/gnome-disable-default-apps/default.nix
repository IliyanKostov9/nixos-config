{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnome-disable-default-apps;
in
{
  options.modules.gnome-disable-default-apps = { enable = mkEnableOption "gnome-disable-default-apps"; };

  config = mkIf cfg.enable {
    environment.gnome.excludePackages = with pkgs.gnome; [
      # baobab # disk usage analyzer
      # cheese # photo booth
      # eog # image viewer
      # epiphany # web browser
      gedit # text editor
      # simple-scan # document scanner
      # totem # video player
      # yelp # help viewer
      # evince # document viewer
      # file-roller # archive manager
      # geary # email client
      # seahorse # password manager

      # these should be self explanatory
      # gnome-calculator
      # gnome-calendar
      # gnome-characters
      # gnome-clocks
      # gnome-contacts
      # gnome-font-viewer
      # gnome-logs
      # gnome-maps
      # gnome-music
      # gnome-photos
      # gnome-screenshot
      # gnome-system-monitor
      # gnome-weather
      # gnome-disk-utility
      # pkgs.gnome-connections
    ];
  };

}
