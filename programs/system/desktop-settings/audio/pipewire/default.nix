{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop-settings.audio.pipewire;
in {
  options.modules.desktop-settings.audio.pipewire = {enable = mkEnableOption "pipewire";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pwvucontrol
    ];
  };
}
