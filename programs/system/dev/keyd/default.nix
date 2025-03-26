{
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.dev.keyd;
in {
  options.modules.dev.keyd = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable keyd
      '';
    };
    mappings = mkOption {
      type = attrs;
      default = {};
      description = mkDoc ''
        Main keymaps for all keyboard layouts
      '';
    };
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = cfg.mappings;
            "right_control_layer" = {
              q = "1";
              w = "2";
            };
          };
        };
      };
    };
  };
}
