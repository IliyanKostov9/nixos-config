{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.kitty;
in
{
  options.modules.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.kitty
    ];
  };

}

