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
  };

  config = {
    console.keyMap = cfg.console;
    services = {
      libinput.enable = true;
      xserver.xkb = {
        layout = "us";
        options = "grp:shifts_toggle";
        # NOTE: Props to: https://github.com/ivangeorgiew for providing the missing Dvorak for bg
        extraLayouts.bgd = {
          description = "Bulgarian Dvorak";
          languages = ["bul"];
          symbolsFile = ../../options/xkb/dvorak/bgd;
        };
      };
    };
  };
}
