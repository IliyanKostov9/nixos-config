{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gtk;
in
{
  options.modules.gtk = { enable = mkEnableOption "gtk"; };

  config = mkIf cfg.enable {
    gtk = {
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-theme-name = "Adwaita";
        gtk-icon-theme-name = "rose-pine";
        # gtk-font-name=Sans 10
        # gtk-cursor-theme-name=DMZ-Black
      };
    };
  };

}

