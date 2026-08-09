{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.options.garbage-collect;
  availableDates = ["weekly" "monthly"];
in {
  options.modules.options.garbage-collect = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = mkDoc ''
        Enable garbage collect
      '';
    };

    schedule = mkOption {
      type = types.str;
      default = "weekly";
      description = mkDoc ''
        Schedule for auto deleting generations
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = builtins.elem cfg.schedule availableDates;
        message = ''
          Schedule is incorrect! Valid values: ${lib.concatStringsSep '', '' availableDates}
        '';
      }
    ];
    nix = {
      settings.auto-optimise-store = true;
      gc = {
        automatic = true;
        dates = cfg.schedule;
        options = "--delete-older-than 7d";
      };
    };
  };
}
