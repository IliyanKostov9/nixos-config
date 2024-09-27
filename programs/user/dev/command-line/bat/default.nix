{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.bat;
in
{
  options.modules.bat = { enable = mkEnableOption "bat"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bat
    ];
  };

}
