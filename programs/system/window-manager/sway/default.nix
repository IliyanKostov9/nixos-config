{
  pkgs,
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
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaybg
        qt5.qtwayland
        wl-clipboard
      ];
    };
  };
}
