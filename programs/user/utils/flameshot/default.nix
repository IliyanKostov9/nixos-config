{
  pkgs,
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
    # NOTE: For wayland
    # home.packages = [
    #   pkgs.grim
    # ];

    services.flameshot = {
      enable = true;
      # NOTE: For wayland
      # package = pkgs.flameshot.overrideAttrs (old: {
      #   enableWlrSupport = true;
      #   cmakeFlags = [
      #     "-DUSE_WAYLAND_CLIPBOARD=true"
      #     "-DUSE_WAYLAND_GRIM=1"
      #   ];
      #   buildInputs = old.buildInputs ++ [pkgs.libsForQt5.kguiaddons];
      # });
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
