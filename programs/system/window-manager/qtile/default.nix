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
    services.displayManager.defaultSession = "qtile";
    services.xserver.windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages:
        with pkgs.python3Packages;
          [
            qtile-extras
          ]
          ++ [pkgs.kbdd];
    };
  };
}
