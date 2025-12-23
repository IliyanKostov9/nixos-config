{
  lib,
  config,
  ...
}:
 with lib; let
  cfg = config.modules.options.locale;
in {
  options.modules.options.locale = {

    timeZone = mkOption {
      type = types.str;
      default = "Europe/Paris";
      description = mkDoc ''
        Define the timezone of the region
        Examples:
        - Europe/Sofia
        - Europe/Paris
      '';
    };

    defaultLocale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = mkDoc ''
        Choose the default locale.
        Choices:
        - en_US.UTF-8
        - den_US.UTF-8e_DE.UTF-8
        - en_US.UTF-8
        - bg_BG.UTF-8
      '';
    };

  };

  config = {
  time.timeZone = cfg.timeZone;
  i18n = {
    inherit (cfg) defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = cfg.defaultLocale;
      LC_IDENTIFICATION = cfg.defaultLocale;
      LC_MEASUREMENT = cfg.defaultLocale;
      LC_MONETARY = cfg.defaultLocale;
      LC_NAME = cfg.defaultLocale;
      LC_NUMERIC = cfg.defaultLocale;
      LC_PAPER = cfg.defaultLocale;
      LC_TELEPHONE = cfg.defaultLocale;
      LC_TIME = cfg.defaultLocale;
    };
  };
  };
}
