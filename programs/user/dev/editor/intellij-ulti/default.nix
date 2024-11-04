{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.intellij-ulti;
in
{
  options.modules.intellij-ulti = { enable = mkEnableOption "intellij-ulti"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jetbrains.idea-ultimate
    ];
  };
}

