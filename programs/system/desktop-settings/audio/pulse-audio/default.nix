{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.audio.pulse-audio;
in {
  options.modules.desktop-settings.audio.pulse-audio = {enable = mkEnableOption "pulse-audio";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };
}
