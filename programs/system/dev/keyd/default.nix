{ lib, config, ... }:
with lib;
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
              capslock = "layer(control)";
              "right" = "f1";
              "down" = "f2";
              "up" = "f3";
              "left" = "f4";
            };
          };
        };
      };
    };
  };
}
