{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Sofia";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "bg_BG.UTF-8";
    LC_IDENTIFICATION = "bg_BG.UTF-8";
    LC_MEASUREMENT = "bg_BG.UTF-8";
    LC_MONETARY = "bg_BG.UTF-8";
    LC_NAME = "bg_BG.UTF-8";
    LC_NUMERIC = "bg_BG.UTF-8";
    LC_PAPER =
      "bg_BG.UTF-8";
    LC_TELEPHONE = "bg_BG.UTF-8";
    LC_TIME = "bg_BG.UTF-8";
  };
}
