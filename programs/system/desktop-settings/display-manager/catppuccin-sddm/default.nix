{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.display-manager.catppuccin-sddm;
in {
  options.modules.desktop-settings.display-manager.catppuccin-sddm = {enable = mkEnableOption "catppuccin-sddm";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          flavor = "macchiato";
          font = "Noto Sans";
          fontSize = "9";
          background = "${./login-wallpaper.jpg}";
          loginBackground = true;
        }
      )
    ];
  };
}
