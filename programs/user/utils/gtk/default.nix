{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types;
with config.modules.preferences; let
  cfg = config.modules.utils.gtk;
in rec {
  options.modules.utils.gtk = {
    themeName = mkOption {
      type = str;
      default = "Adwaita:dark";
      description = mkDoc ''
        Theme name for gtk
      '';
    };
    cursorName = mkOption {
      type = str;
      default = "DMZ-Black";
      description = mkDoc ''
        Cursor name for gtk
      '';
    };
    iconName = mkOption {
      type = str;
      default = "rose-pine";
      description = mkDoc ''
        Icon name for gtk
      '';
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
        name = "${fonts.name}";
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name = "${cfg.iconName}";
        gtk-theme-name = "${cfg.themeName}";
        gtk-cursor-theme-name = "${cfg.cursorName}";
        gtk-font-name = "${fonts.name}";
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
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
