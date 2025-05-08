{
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.window-manager.i3wm;
in {
  options.modules.window-manager.i3wm = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable i3 window manager
      '';
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver.windowManager.i3.enable = true;
      displayManager.defaultSession = "none+i3";
    };
    environment.pathsToLink = ["/libexec"];
  };
}
