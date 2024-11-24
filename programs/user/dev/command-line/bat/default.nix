{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.bat;
in
{
  options.modules.dev.command-line.bat = { enable = mkEnableOption "bat"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bat
    ];
  };

}
