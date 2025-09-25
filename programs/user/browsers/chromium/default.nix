{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.browsers.chromium;
in {
  options.modules.browsers.chromium = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable chromium
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        "--kiosk"
        "--noerrdialogs"
        "--disable-infobars"
        "--no-first-run"
        "--ozone-platform=wayland"
        "--enable-features=OverlayScrollbar"
        "--hide-crash-restore-bubble"
        "--hide-scrollbars"
      ];
    };
  };
}
