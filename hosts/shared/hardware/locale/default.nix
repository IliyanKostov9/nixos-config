{ ... }:

let
  locale-bg = "bg_BG.UTF-8";
in
{
  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale-bg;
    LC_IDENTIFICATION = locale-bg;
    LC_MEASUREMENT = locale-bg;
    LC_MONETARY = locale-bg;
    LC_NAME = locale-bg;
    LC_NUMERIC = locale-bg;
    LC_PAPER =
      locale-bg;
    LC_TELEPHONE = locale-bg;
    LC_TIME = locale-bg;
  };
}
