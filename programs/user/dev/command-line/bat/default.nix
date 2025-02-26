{ lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.bat;
in
{
  options.modules.dev.command-line.bat = { enable = mkEnableOption "bat"; };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "base16-256";
        color = "always";
        style = "numbers";
      };
    };
  };
}
