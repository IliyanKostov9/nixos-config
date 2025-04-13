{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.editor.android-studio;
in {
  options.modules.dev.editor.android-studio = {enable = mkEnableOption "android-studio";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.android-studio
    ];
  };
}
