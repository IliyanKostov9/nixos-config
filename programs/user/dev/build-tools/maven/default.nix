{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.maven;
in
{
  options.modules.maven = { enable = mkEnableOption "maven"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.maven
    ];
  };

}

