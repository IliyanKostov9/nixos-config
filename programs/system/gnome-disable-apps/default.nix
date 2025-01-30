{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gnome-disable-apps;
in
{
  options.modules.gnome-disable-apps = { enable = mkEnableOption "gnome-disable-default-apps"; };

  config = mkIf cfg.enable {
    environment.gnome.excludePackages = with pkgs; [
      eog # Image viewer
      epiphany # web browser
      gedit # text editor
      simple-scan # document scanner
      yelp # help viewer
      evince # document viewer
      totem # video player
      geary # email client
      gnome-calculator
      gnome-characters
      # gnome-clocks
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-connections
      gnome-font-viewer

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
