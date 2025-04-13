{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.make;
in {
  options.modules.utils.make = {enable = mkEnableOption "make";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      # cmake
    ];
  };
}
