{ pkgs, lib, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.gtk;
  font-name = config.modules.fonts.name;
in
rec {
  options.modules.gtk = {
    themeName = mkOption {
      type = str;
      default = "Adwaita";
    };
    cursorName = mkOption {
      type = str;
      default = "DMZ-White";
    };
    iconName = mkOption {
      type = str;
      default = "rose-pine";
    };
  };

  config = {
    # FIX: If the cursor theme doesn't work, then change it manually at: ~/.icons/default/index.theme
    gtk = {
      enable = true;
      theme = {
        name = "${cfg.themeName}";
      };
      cursorTheme = {
        name = "${cfg.cursorName}";
      };
      iconTheme = {
        name = "${cfg.iconName}";
        package = pkgs."${cfg.iconName}-icon-theme";
      };
      font = {
        name = "${font-name}";
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name = "${cfg.iconName}";
        gtk-theme-name = "${cfg.themeName}";
        gtk-cursor-theme-name = "${cfg.cursorName}";
        gtk-font-name = "${font-name}";

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

