{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.office-suite.libreoffice;
in
{
  options.modules.office-suite.libreoffice = { enable = mkEnableOption "libreoffice"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
      hunspellDicts.en_US
    ];
  };

}
