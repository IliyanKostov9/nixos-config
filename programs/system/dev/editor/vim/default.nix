{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.editor.vim;
in {
  options.modules.dev.editor.vim = {enable = mkEnableOption "vim";};

  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      defaultEditor = lib.mkDefault false;
    };
  };
}
