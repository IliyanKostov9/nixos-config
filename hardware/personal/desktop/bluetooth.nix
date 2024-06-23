{ config, lib, pkgs, ... }:

{
  # Enable bloothooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.Policy.AutoEnable = "true";
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
}
