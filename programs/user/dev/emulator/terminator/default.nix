{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.terminator;
in
{
  options.modules.terminator = { enable = mkEnableOption "terminator"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.terminator
    ];
  };

}

