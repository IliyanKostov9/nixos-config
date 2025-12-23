{
  user,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.flameshot;
in {
  options.modules.utils.flameshot = {enable = mkEnableOption "flameshot";};

  config = mkIf cfg.enable {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
          showDesktopNotification = false;
          savePath = "/home/${user}/Pictures";
        };
      };
    };
  };
}
