{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.make;
in {
  options.modules.dev.make = {enable = mkEnableOption "make";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      # cmake
    ];
  };
}
