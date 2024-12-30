{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.build-tools.make;
in
{
  options.modules.utils.make = { enable = mkEnableOption "make"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pkgs.gnumake
      # cmake
    ];
  };

}

