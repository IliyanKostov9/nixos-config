{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.build-tools.make;
in
{
  options.modules.dev.build-tools.make = { enable = mkEnableOption "make"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gnumake
      # cmake
    ];
  };

}

