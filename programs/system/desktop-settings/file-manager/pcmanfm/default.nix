{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.desktop-settings.file-manager.pcmanfm;
in
{
  options.modules.desktop-settings.file-manager.pcmanfm = { enable = mkEnableOption "pcmanfm"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pcmanfm ];
  };
}

