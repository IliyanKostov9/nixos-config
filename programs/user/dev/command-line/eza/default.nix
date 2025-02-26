{ lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.eza;
in
{
  options.modules.dev.command-line.eza = { enable = mkEnableOption "eza"; };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      colors = "always";
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
