{ lib, config, ... }:
with lib;
with lib.types;
let cfg = config.modules.dev.keyd;
in
{
  options.modules.dev.keyd = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable keyd
      '';
    };
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              "f1" = "left";
              "f2" = "down";
              "f3" = "up";
              "f4" = "right";
              "left" = "f1";
              "down" = "f2";
              "up" = "f3";
              "right" = "f4";

              "rightshift" = "backspace";
            };
          };
        };
      };
    };
  };
}
