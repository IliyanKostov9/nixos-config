{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.drawio;
in
{
  options.modules.drawio = { enable = mkEnableOption "drawio"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.drawio
    ];
  };

}

