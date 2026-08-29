{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.display-manager.catppuccin-sddm;
  flavor = "macchiato";
  accent = "flamingo";
in {
  options.modules.desktop-settings.display-manager.catppuccin-sddm = {enable = mkEnableOption "catppuccin-sddm";};

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          inherit flavor accent;
          font = "Noto Sans";
          fontSize = "14";
          background = "${./login-wallpaper.jpg}";
          loginBackground = true;
        }
      )
    ];
    services.displayManager.sddm.theme = "catppuccin-${flavor}-${accent}";
  };
}
