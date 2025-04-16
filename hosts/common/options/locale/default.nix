_: let
  defaultLocale = "en_US.UTF-8";
  # de_DE.UTF-8
  # en_US.UTF-8
  # bg_BG.UTF-8
in {
  time.timeZone = "Europe/Sofia";

  i18n = {
    inherit defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };
}
