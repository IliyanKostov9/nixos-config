{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gtk;
in
{
  options.modules.gtk = { enable = mkEnableOption "gtk"; };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita";
      };
      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name = "rose-pine";
        gtk-theme-name = "Adwaita";
        gtk-cursor-theme-name = "Adwaita";

        gtk-font-name = "Sans 10";
        gtk-cursor-theme-size = 0;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 0;
        gtk-menu-images = 0;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintmedium";
        gtk-xft-rgba = "none";
      };
    };
  };

}

