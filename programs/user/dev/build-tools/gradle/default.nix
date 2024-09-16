{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.gradle;
in
{
  options.modules.gradle = { enable = mkEnableOption "gradle"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gradle
    ];
  };

}

