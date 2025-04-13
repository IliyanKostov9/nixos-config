{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.editor.texstudio;
in {
  options.modules.dev.editor.texstudio = {enable = mkEnableOption "texstudio";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.texstudio
    ];
  };
}
