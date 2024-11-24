{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.editor.intellij-ulti;
in
{
  options.modules.dev.editor.intellij-ulti = { enable = mkEnableOption "intellij-ulti"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jetbrains.idea-ultimate
    ];
  };
}

