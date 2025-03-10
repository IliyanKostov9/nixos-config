{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.vim;
in {
  options.modules.editor.vim = {enable = mkEnableOption "vim";};

  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      defaultEditor = lib.mkDefault false;
    };
  };
}
