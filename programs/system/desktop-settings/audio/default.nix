{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop-settings.audio;
in
{
  options.modules.desktop-settings.audio = { enable = mkEnableOption "audio"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };
}

