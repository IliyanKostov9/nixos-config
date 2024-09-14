{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vscodium;
in
{
  options.modules.vscodium = { enable = mkEnableOption "vscodium"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vscodium
    ];
  };

}

