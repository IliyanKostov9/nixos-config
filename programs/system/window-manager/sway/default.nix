{
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.window-manager.sway;
in {
  options.modules.window-manager.sway = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable sway window manager
      '';
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.defaultSession = "sway";
    security.polkit.enable = true;
    # NOTE: Used for external SSD card
    services.udisks2.enable = true;
    programs.xwayland.enable = false;

    programs.sway = {
      enable = true;
      package = pkgs-unstable.sway;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs-unstable; [
        swaybg
        qt5.qtwayland
        wl-clipboard
      ];
      extraSessionCommands = ''
        # Tell toolkits to use wayland
        export CLUTTER_BACKEND=wayland
        #export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export SDL_VIDEODRIVER=wayland

        # Fix krita and other Egl-using apps
        export LD_LIBRARY_PATH=/run/opengl-driver/lib

        # Disable HiDPI scaling for X apps
        # https://wiki.archlinux.org/index.php/HiDPI#GUI_toolkits
        export GDK_SCALE=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
      '';
    };
  };
}
