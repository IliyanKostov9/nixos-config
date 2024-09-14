{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.kotlin;
in
{
  options.modules.kotlin = { enable = mkEnableOption "kotlin"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.kotlin
    ];
  };

}


