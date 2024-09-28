{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnome-disable-default-apps;
in
{
  options.modules.gnome-disable-default-apps = { enable = mkEnableOption "gnome-disable-default-apps"; };

  config = mkIf cfg.enable {
    environment.gnome.excludePackages = with pkgs; [
      gnome.eog # Image viewer
      epiphany # web browser
      gedit # text editor
      simple-scan # document scanner
      yelp # help viewer
      evince # document viewer
      gnome.totem # video player
      gnome.geary # email client
      gnome.gnome-calculator
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-contacts
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-music
      gnome-connections
      gnome.gnome-font-viewer

      # baobab # disk usage analyzer
      # cheese # photo booth
      # seahorse # password manager
      # file-roller # archive manager
      # gnome-calendar
      # gnome-photos
      # gnome-screenshot
      # gnome-system-monitor
      # gnome-weather
      # gnome-disk-utility
    ];
  };
}
