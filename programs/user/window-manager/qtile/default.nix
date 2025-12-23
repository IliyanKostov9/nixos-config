{
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
    xdg.configFile."qtile/config.py".source = ./src/config.py;
  };
}
