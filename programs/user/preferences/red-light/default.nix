{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.red-light;
in
{
  options.modules.red-light = { enable = mkEnableOption "red-light"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ redshift ];

    services.redshift.settings = {
      redshift = {
        temp-day = 6500;
        temp-night = 3000;
        transition = 1;
        gamma = "0.8:0.7:0.8";
        location-provider = "manual";
        adjustment-method = "randr";
      };
      manual = {
        lat = 43.216640;
        lon = 27.911810;
      };

      randr = {
        screen = 0;
      };

      period = {
        night = "21:00-7:00";
        day = "7:00-21:00";
      };
    };
  };

}

