{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.command-line.eza;
in {
  options.modules.dev.command-line.eza = {enable = mkEnableOption "eza";};

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      git = true;
      icons = "never";
      colors = "auto";
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
