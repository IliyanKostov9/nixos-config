{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.macos;
in
{
  options.modules.macos = { enable = mkEnableOption "macos"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.darling
    ];
  };

}

