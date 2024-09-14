{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.audio;
in
{
  options.modules.audio = { enable = mkEnableOption "audio"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };

}

