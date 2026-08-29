{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.office-suite;
in {
  options.modules.office-suite = {enable = mkEnableOption "office-suite";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      copyq
      libreoffice
      kdePackages.okular
    ];
  };
}
