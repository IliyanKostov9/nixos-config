{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.style;
in {
  options.modules.style = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable stylix
      '';
    };

    theme = mkOption {
      type = str;
      default = "kanagawa Dragon";
      description = mkDoc ''
        Color scheme for the system
      '';
    };

    polarity = mkOption {
      type = str;
      default = "dark";
      description = mkDoc ''
        Light/dark theme
      '';
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.theme}.yaml";
      polarity = cfg.polarity;
    };
  };
}
