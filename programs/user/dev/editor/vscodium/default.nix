{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.editor.vscodium;
in {
  options.modules.dev.editor.vscodium = {enable = mkEnableOption "vscodium";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vscodium
    ];
  };
}
