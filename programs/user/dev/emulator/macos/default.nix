{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.emulator.macos;
in {
  options.modules.dev.emulator.macos = {enable = mkEnableOption "macos";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.darling
    ];
  };
}
