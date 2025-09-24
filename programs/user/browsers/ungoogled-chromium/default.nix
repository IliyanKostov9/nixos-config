{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.browsers.ungoogled-chromium;
in {
  options.modules.browsers.ungoogled-chromium = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable ungoogled-chromium
      '';
    };

    package = mkOption {
      default = pkgs.ungoogled-chromium;
      description = mkDoc ''
        Use ungoogled-chromium package
      '';
    };
  };

  config = mkIf cfg.enable {
      programs.chromium = {
        enable = true;
      inherit (cfg) package;
        extensions = [
          # Dark reader
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
          # Ublock origin
          "ddkjiahejlhfcafbddmgiahcphecmpfh"
          # Privacy Badger
          # "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
          # User agent switcher
          "bhchdcejhohfmigjafbampogmaanbfkg"
          # I don't care about cookies
          "fihnjjcciajhdojfnbdddfaoknhalnja"
          # Canvas blocker
          # "nomnklagbgmgghhjidfhnoelnjfndfpd"
        ];
      };
    };
  };
}
