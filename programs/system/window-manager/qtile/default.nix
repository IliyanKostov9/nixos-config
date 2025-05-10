{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.window-manager.qtile;
in {
  options.modules.window-manager.qtile = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable qtile window manager
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        xdg-desktop-portal
      ];
    };
    programs.xwayland.enable = true;
    services.xserver.displayManager.sessionPackages = [pkgs.qtile-unwrapped];
    services.displayManager.defaultSession = "qtile";
    services.xserver.windowManager.qtile = {
      enable = true;
      package = pkgs.qtile-unwrapped;
      extraPackages = python3Packages:
        with pkgs.python3Packages;
          [
            qtile-extras
          ]
          ++ [pkgs.kbdd];
    };
  };
}
