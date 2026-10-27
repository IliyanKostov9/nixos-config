{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.magic-mouse;
in {
  options.modules.desktop-settings.magic-mouse = {enable = mkEnableOption "magic-mouse";};

  config = mkIf cfg.enable {
    hardware.uinput.enable = true;
    services.mousetouch.enable = true;
  };
}
