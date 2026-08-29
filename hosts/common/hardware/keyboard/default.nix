{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.keyboard;
in {
  options.modules.hardware.keyboard = {
    console = mkOption {
      type = types.str;
      default = "dvorak";
      description = mkDoc ''
        Keyboard for the console
      '';
    };

    extraLayouts = mkOption {
      default = {};
      description = mkDoc ''
        Extra keyboard layouts
      '';
    };
  };

  config = {
    console.keyMap = cfg.console;
    services = {
      libinput.enable = true;
      xserver.xkb = {
        layout = "us";
        variant = cfg.console;
        options = "grp:shifts_toggle";
        inherit (cfg) extraLayouts;
      };
    };
  };
}
